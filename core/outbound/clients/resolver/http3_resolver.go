package resolver

import (
	"bytes"
	"context"
	"crypto/tls"
	"io"
	"net"
	"net/http"

	"github.com/miekg/dns"
	"github.com/quic-go/quic-go"
	"github.com/quic-go/quic-go/http3"
)

type HTTP3Resolver struct {
	BaseResolver
	client http.Client
}

func (r *HTTP3Resolver) Exchange(q *dns.Msg) (*dns.Msg, error) {
	request, err := q.Pack()
	resp, err := r.client.Post(r.dnsUpstream.Address, "application/dns-message",
		bytes.NewBuffer(request))
	if err != nil {
		return nil, err
	}
	defer resp.Body.Close()
	data, err := io.ReadAll(resp.Body)
	if err != nil {
		return nil, err
	}
	msg := new(dns.Msg)
	err = msg.Unpack(data)
	if err != nil {
		return nil, err
	}
	return msg, nil
}

func (r *HTTP3Resolver) Init() error {
	err := r.BaseResolver.Init()
	if err != nil {
		return err
	}
	r.client = http.Client{
		Transport: &http3.RoundTripper{
			Dial: func(ctx context.Context, addr string, tlsCfg *tls.Config, cfg *quic.Config) (quic.EarlyConnection, error) {
				return quic.DialEarly(ctx, &net.IPConn{}, &net.UDPAddr{}, tlsCfg, cfg)
			},
		},
	}
	return nil
}

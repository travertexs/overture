package resolver

import (
	"bytes"
	"io"
	"net"
	"net/http"

	"github.com/miekg/dns"
)

type HTTPSResolver struct {
	BaseResolver
	client http.Client
}

func (r *HTTPSResolver) Exchange(q *dns.Msg) (*dns.Msg, error) {
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

func (r *HTTPSResolver) Init() error {
	err := r.BaseResolver.Init()
	if err != nil {
		return err
	}
	r.client = http.Client{
		Transport: &http.Transport{
			Dial: func(network, addr string) (net.Conn, error) {
				return r.CreateBaseConn()
			},
		},
	}
	return nil
}

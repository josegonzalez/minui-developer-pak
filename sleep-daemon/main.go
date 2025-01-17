package main

import (
	"context"
	"os"
	"os/signal"
	"syscall"
)

func main() {
	// sleep until we get a kill or interrupt signal
	signals := make(chan os.Signal, 1)
	signal.Notify(signals, os.Interrupt, syscall.SIGHUP,
		syscall.SIGINT,
		syscall.SIGQUIT,
		syscall.SIGTERM)
	ctx, cancel := context.WithCancel(context.Background())
	go func() {
		<-signals
		cancel()
	}()

	<-ctx.Done()
}

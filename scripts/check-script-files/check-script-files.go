package main

import (
	"fmt"
	"os"

	"github.com/fatih/color"
)

func PrintError(text string) {
	color.New(color.BgRed, color.FgWhite).Print("error")
	color.Red(": %s", text)
}

func PrintMessage(text string) {
	color.New(color.BgGreen, color.FgWhite).Print("info")
	color.Green(": %s", text)
}

func main() {
	directories, err := os.ReadDir("../../src")
	if err != nil {
		PrintError(err.Error())
		os.Exit(1)
	}

	for _, directory := range directories {
		if !directory.IsDir() && directory.Name() == ".markdownlint.yaml" {
			continue
		}

		if !directory.IsDir() {
			PrintError(fmt.Sprintf("%s is not a directory", directory.Name()))
			os.Exit(1)
		}

		files, err := os.ReadDir(fmt.Sprintf("../../src/%s", directory.Name()))
		if err != nil {
			PrintError(err.Error())
			os.Exit(1)
		}

		seenUIScreenshot, seenResultScreenshot := false, false

		for _, file := range files {
			if !directory.IsDir() && directory.Name() == "ui.png" {
				seenUIScreenshot = true
			}

			if !directory.IsDir() && directory.Name() == "result.png" {
				seenResultScreenshot = true
			}

			if file.IsDir() {
				PrintError(fmt.Sprintf("%s is a directory", file.Name()))
				os.Exit(1)
			}

			if seenUIScreenshot != seenResultScreenshot {
				PrintError("both ui.png and result.png should present in case one of them exists")
				os.Exit(1)
			}
		}

		PrintMessage(fmt.Sprintf("%s is valid", directory.Name()))
	}
}

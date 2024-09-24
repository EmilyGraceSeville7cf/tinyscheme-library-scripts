package main

import (
	"fmt"
	"os"
	"path"

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
	srcPath := path.Join("..", "..", "src")
	directories, err := os.ReadDir(srcPath)
	if err != nil {
		PrintError(err.Error())
		os.Exit(1)
	}

	status := 0

	for _, directory := range directories {
		if !directory.IsDir() && directory.Name() == ".markdownlint.yaml" {
			continue
		}

		if !directory.IsDir() {
			PrintError(fmt.Sprintf("%s is not a directory in %s", directory.Name(), srcPath))
			status = 1
			continue
		}

		scriptPath := path.Join(srcPath, directory.Name())
		files, err := os.ReadDir(scriptPath)
		if err != nil {
			PrintError(err.Error())
			status = 1
			continue
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
				PrintError(fmt.Sprintf("%s is a directory in %s", file.Name(), scriptPath))
				status = 1
				continue
			}

			if seenUIScreenshot != seenResultScreenshot {
				PrintError(fmt.Sprintf("both ui.png and result.png should present in case one of them exists in %s", scriptPath))
				status = 1
				continue
			}
		}

		PrintMessage(fmt.Sprintf("%s is valid", directory.Name()))
	}

	os.Exit(status)
}

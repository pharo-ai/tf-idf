# Term Frequency - Inverse Document Frequency (TF-IDF)

![https://github.com/pharo-ai/TF-IDF/workflows/test/badge.svg](https://github.com/pharo-ai/TF-IDF/workflows/test/badge.svg)

[![Build Status](https://travis-ci.org/pharo-ai/TF-IDF.svg?branch=master)](https://travis-ci.org/pharo-ai/TF-IDF)
[![Build status](https://ci.appveyor.com/api/projects/status/plkr5qalvfl89xtd?svg=true)](https://ci.appveyor.com/project/olekscode/tf-idf)
[![Coverage Status](https://coveralls.io/repos/github/pharo-ai/TF-IDF/badge.svg?branch=master)](https://coveralls.io/github/pharo-ai/TF-IDF?branch=master)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://raw.githubusercontent.com/pharo-ai/TF-IDF/master/LICENSE)

This repository contains the implementation of TF-IDF algorithm in Pharo.

## How to install it?

To install `TF-IDF`, go to the Playground (Ctrl+OW) in your [Pharo](https://pharo.org/) image and execute the following Metacello script (select it and press Do-it button or Ctrl+D):

```Smalltalk
Metacello new
  baseline: 'Tfidf';
  repository: 'github://pharo-ai/TF-IDF/src';
  load.
```

## How to depend on it?

If you want to add a dependency on `TF-IDF` to your project, include the following lines into your baseline method:

```Smalltalk
spec
  baseline: 'Tfidf'
  with: [ spec repository: 'github://pharo-ai/TF-IDF/src' ].
```

If you are new to baselines and Metacello, check out the [Baselines](https://github.com/pharo-open-documentation/pharo-wiki/blob/master/General/Baselines.md) tutorial on Pharo Wiki.

## How to use it?

Here is a simple example of how you can train a TF-IDF model and use it to assign scores to words. You are given an array of sentences where each sentence is represented as an array of words:

```Smalltalk
sentences := #(
  (I am Sam)
  (Sam I am)
  (I 'don''t' like green eggs and ham)).
```

You can train a TF-IDF model on those sentences:

```Smalltalk
tfidf := TermFrequencyInverseDocumentFrequency new.
tfidf trainOn: sentences.
```

Now you can use it to assign TF-IDF scores to words:

```Smalltalk
tfidf scoreOf: 'Sam' in: #(I am Sam). "0.4054651081081644"
tfidf scoreOf: 'I' in: #(I am Sam). "0.0"
tfidf scoreOf: 'green' in: #(I am green green ham). "2.1972245773362196"
```

You can also encode any given text with a TF-IDF vector, which will contain a TF-IDF score for each word from the vocabulary of unique words extracted from sentences on which TF-IDF was trained:

```Smalltalk
tfidf vectorFor: #(I am green green ham). "#(0.0 0.0 0.4054651081081644 0.0 0.0 0.0 2.1972245773362196 1.0986122886681098 0.0)"
```

Those vectors can be used to find semantic similarities between different texts.

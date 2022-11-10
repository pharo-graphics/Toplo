Class {
	#name : #ToAlbumTest,
	#superclass : #ToTestCase,
	#category : #'Toplo-Tests-Widgets'
}

{ #category : #tests }
ToAlbumTest >> testModel1 [

	| widget |
	widget := ToAlbumModel new onWidget.
	self assert: widget viewModel text identicalTo: widget text.
	self assert: widget innerElement text identicalTo: widget text.
	
	widget text: ''.
	self assert: widget text asString equals: ''.
	self assert: widget viewModel text identicalTo: widget text.
	self assert: widget innerElement text identicalTo: widget text.
	
	widget innerElement text: '' asRopedText .
	self assert: widget text asString equals: ''.
	self assert: widget viewModel text identicalTo: widget text.
	self assert: widget innerElement text identicalTo: widget text.
	
	widget text: 'This is a text'.
	self assert: widget text asString equals: 'This is a text'.
	self assert: widget viewModel text identicalTo: widget text.
	self assert: widget innerElement text identicalTo: widget text.
	
	widget viewModel text: 'This is a text 2' asRopedText .
	self assert: widget text asString equals: 'This is a text 2'.
	self assert: widget viewModel text identicalTo: widget text.
	self assert: widget innerElement text identicalTo: widget text.
	
	widget text: nil.
	self assert: widget viewModel text identicalTo: widget text.
	self assert: widget innerElement text identicalTo: widget text.
	

]

{ #category : #tests }
ToAlbumTest >> testModel2 [

	| widget |
	widget := ToAlbum new .
	self assert: widget viewModel text identicalTo: widget text.
	self assert: widget innerElement text identicalTo: widget text.
	
	widget text: ''.
	self assert: widget text asString equals: ''.
	self assert: widget viewModel text identicalTo: widget text.
	self assert: widget innerElement text identicalTo: widget text.
	
	widget innerElement text: '' asRopedText .
	self assert: widget text asString equals: ''.
	self assert: widget viewModel text identicalTo: widget text.
	self assert: widget innerElement text identicalTo: widget text.
	
	widget text: 'This is a text'.
	self assert: widget text asString equals: 'This is a text'.
	self assert: widget viewModel text identicalTo: widget text.
	self assert: widget innerElement text identicalTo: widget text.
	
	widget viewModel text: 'This is a text 2' asRopedText .
	self assert: widget text asString equals: 'This is a text 2'.
	self assert: widget viewModel text identicalTo: widget text.
	self assert: widget innerElement text identicalTo: widget text.
	
	widget text: nil.
	self assert: widget viewModel text identicalTo: widget text.
	self assert: widget innerElement text identicalTo: widget text.
	

]

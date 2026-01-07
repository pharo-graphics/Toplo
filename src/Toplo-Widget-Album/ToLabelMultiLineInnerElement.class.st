Class {
	#name : #ToLabelMultiLineInnerElement,
	#superclass : #BlElement,
	#traits : 'TToLabelInnerElement',
	#classTraits : 'TToLabelInnerElement classTrait',
	#instVars : [
		'lines',
		'text'
	],
	#category : #'Toplo-Widget-Album-Label'
}

{ #category : #'private - text splitting' }
ToLabelMultiLineInnerElement >> collectNewLines [

	^ Array streamContents: [ :stream |
		  | itor lineElement |
		  text
			  ifEmpty: [
				  lineElement := self newLineElement.
				  lineElement addChild: self emptyTextElement.
				  stream nextPut: lineElement ]
			  ifNotEmpty: [
				  itor := text iterator.
				  [ itor hasNext ] whileTrue: [
					  | textElements |
					  textElements := OrderedCollection new.
					  itor nextLineIndicesDo: [ :aLineStart :aLineEnd :aLineDelimiterEnd |
						  | lineText cutted |
						  lineText := text from: aLineStart to: aLineEnd.
						  cutted := ToTextScissor new cut: lineText.
						  cutted
							  ifEmpty: [ textElements add: self emptyTextElement ]
							  ifNotEmpty: [
								  textElements addAll:
									  (cutted collect: [ :w | self newTextElementWith: w ]) ] ].
					  lineElement := self newLineElement.
					  lineElement addChildren: textElements.
					  stream nextPut: lineElement ] ] ]
]

{ #category : #'private - text splitting' }
ToLabelMultiLineInnerElement >> emptyLineText [

	^ BlText empty attributes: text iterator attributes
]

{ #category : #'private - text splitting' }
ToLabelMultiLineInnerElement >> emptyTextElement [

	^ self newTextElementWith: self emptyLineText
]

{ #category : #initialization }
ToLabelMultiLineInnerElement >> initialize [

	super initialize.

	lines := #(  ).
	self fitContent.
	self layout: BlLinearLayout vertical.
	self preventMouseEvents
]

{ #category : #testing }
ToLabelMultiLineInnerElement >> isMonoLine [ 

	^ false
]

{ #category : #'instance creation' }
ToLabelMultiLineInnerElement >> newEditor [

	| ed |
	ed := ToAlbum new.
	ed hMatchParent.
	ed vFitContent.
	ed next fitContent.
	ed infinite fitContent.
	^ ed
]

{ #category : #'private - text splitting' }
ToLabelMultiLineInnerElement >> newLineElement [

	^ AlbTextEditorSegmentElement new
		  layout: BlFlowLayout new;
		  fitContent;
		  yourself
]

{ #category : #'private - text splitting' }
ToLabelMultiLineInnerElement >> newTextElement [

	^ ToLabelMultiLineTextElement new 
]

{ #category : #'private - text splitting' }
ToLabelMultiLineInnerElement >> newTextElementWith: aText [

	^ ToLabelMultiLineTextElement new text: aText; yourself
]

{ #category : #'private - text splitting' }
ToLabelMultiLineInnerElement >> splitText [

	lines ifNotEmpty: [
		self removeChildren: lines.
		lines := #(  ) ].
	"text ifNil: [ ^ self ]."
	text ifEmpty: [ ^ self ].
	lines := self collectNewLines.
	self addChildren: lines
]

{ #category : #'t - label inner element' }
ToLabelMultiLineInnerElement >> text [

	^ text 
]

{ #category : #'t - label inner element' }
ToLabelMultiLineInnerElement >> text: aBlText [

	text = aBlText ifTrue: [ ^ self ].
	text := aBlText.
	self splitText
]

{ #category : #'event handling' }
ToLabelMultiLineInnerElement >> textChanged [

	lines do: [ :l | l childrenDo: [ :child | child textChanged ] ]
]

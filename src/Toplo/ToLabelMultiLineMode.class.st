Class {
	#name : #ToLabelMultiLineMode,
	#superclass : #ToLabelLineMode,
	#category : #'Toplo-Widget-Labels'
}

{ #category : #initialization }
ToLabelMultiLineMode >> newTextElementIn: aLabel [

	^ ToLabelMultiLineInnerElement  new
]

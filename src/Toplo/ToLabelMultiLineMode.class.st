Class {
	#name : #ToLabelMultiLineMode,
	#superclass : #ToLabelLineMode,
	#category : #'Toplo-Widget-Label'
}

{ #category : #initialization }
ToLabelMultiLineMode >> newTextElementIn: aLabel [

	^ ToLabelMultiLineInnerElement  new
]

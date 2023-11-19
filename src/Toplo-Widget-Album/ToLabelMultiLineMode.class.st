Class {
	#name : #ToLabelMultiLineMode,
	#superclass : #ToLabelLineMode,
	#category : 'Toplo-Widget-Album-Label'
}

{ #category : #initialization }
ToLabelMultiLineMode >> isMultiLine [ 

	^ true
]

{ #category : #initialization }
ToLabelMultiLineMode >> newTextElementIn: aLabel [

	^ ToLabelMultiLineInnerElement  new
]

Class {
	#name : 'ToLabelMultiLineMode',
	#superclass : 'ToLabelLineMode',
	#category : 'Toplo-Widget-Album-Label',
	#package : 'Toplo-Widget-Album',
	#tag : 'Label'
}

{ #category : 'initialization' }
ToLabelMultiLineMode >> isMultiLine [ 

	^ true
]

{ #category : 'initialization' }
ToLabelMultiLineMode >> newTextElementIn: aLabel [

	^ ToLabelMultiLineInnerElement  new
]

Class {
	#name : #ToLabelStencilMode,
	#superclass : #ToLabelLineMode,
	#category : #'Toplo-Widget-Labels'
}

{ #category : #'instance creation' }
ToLabelStencilMode >> newTextElementIn: aLabel [

	^ aLabel innerElementStencil value: self
]

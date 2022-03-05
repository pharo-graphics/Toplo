Class {
	#name : #ToLayoutResizerElementPropagations,
	#superclass : #BrLayoutResizerPropagations,
	#instVars : [
		'element'
	],
	#category : #'Toplo-Core-Layout Resizer'
}

{ #category : #'adding / removing' }
ToLayoutResizerElementPropagations >> addPropagation: aBrLayoutResizerPropagation [
	super addPropagation: aBrLayoutResizerPropagation.
	
	self element requestStyle
]

{ #category : #'adding / removing' }
ToLayoutResizerElementPropagations >> addPropagations: aBrLayoutResizerPropagations [
	super addPropagations: aBrLayoutResizerPropagations.
	
	self element requestStyle
]

{ #category : #accessing }
ToLayoutResizerElementPropagations >> element [
	^ element
]

{ #category : #accessing }
ToLayoutResizerElementPropagations >> element: anObject [
	element := anObject
]

{ #category : #'adding / removing' }
ToLayoutResizerElementPropagations >> removePropagation: aBrLayoutResizerPropagation [
	super removePropagation: aBrLayoutResizerPropagation.
	
	self element requestStyle
]

{ #category : #'adding / removing' }
ToLayoutResizerElementPropagations >> removePropagations: aBrLayoutResizerPropagations [
	super removePropagations: aBrLayoutResizerPropagations.
	
	self element requestStyle
]

Class {
	#name : #ToSelectDataListNode,
	#superclass : #ToSelectListNode,
	#category : #'Toplo-Widget-Select-Node'
}

{ #category : #skin }
ToSelectDataListNode >> installRawStyle [

	| verticalPadding leftPadding rightPadding |
	super installRawStyle.
	self holder isUnselectable ifTrue: [ self background: (Color yellow alpha: 0.3)].
	verticalPadding := self valueOfTokenNamed: #'padding-content-V'.
	rightPadding := self valueOfTokenNamed: #'padding-content-H'.
	leftPadding := self valueOfTokenNamed: #'padding-content-H'.
	self padding: (BlInsets
			 top: verticalPadding
			 left: leftPadding
			 bottom: verticalPadding
			 right: rightPadding)
]

{ #category : #skin }
ToSelectDataListNode >> newRawSkin [ 

	^ ToSelectDataListNodeSkin new
]

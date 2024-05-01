Class {
	#name : #ToSelectDataListNode,
	#superclass : #ToSelectListNode,
	#category : #'Toplo-Widget-Select-List'
}

{ #category : #skin }
ToSelectDataListNode >> installRawStyle [

	| verticalPadding leftPadding rightPadding |
	super installRawStyle.
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

Class {
	#name : #ToSelectGroupListNode,
	#superclass : #ToSelectListNode,
	#category : #'Toplo-Widget-Select-Node'
}

{ #category : #skin }
ToSelectGroupListNode >> installRawStyle [

	| verticalPadding leftPadding rightPadding label |
	super installRawStyle.
	verticalPadding := self valueOfTokenNamed: #'padding-content-V'.
	rightPadding := self valueOfTokenNamed: #'padding-content-H'.
	leftPadding := (self valueOfTokenNamed: #'padding-content-H') / 3.
	self padding: (BlInsets
			 top: verticalPadding + 6
			 left: leftPadding
			 bottom: verticalPadding
			 right: rightPadding).
	label := self firstChild.
	label text
		foreground: Color lightGray;
		light.
	label textChanged
]

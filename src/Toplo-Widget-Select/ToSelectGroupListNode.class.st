Class {
	#name : #ToSelectGroupListNode,
	#superclass : #ToListNode,
	#category : #'Toplo-Widget-Select-List'
}

{ #category : #skin }
ToSelectGroupListNode >> installRawStyle [

	| label |
	super installRawStyle.
	self padding:
		((self padding withTop: self padding top + 6) withBottom:
			 self padding bottom + 3).
	label := self firstChild.
	label foreground: Color lightGray.
	label applyStyle
]

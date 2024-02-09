Class {
	#name : #ToSelectListNode,
	#superclass : #ToNode,
	#instVars : [
		'select'
	],
	#category : #'Toplo-Widget-Select-Node'
}

{ #category : #skin }
ToSelectListNode >> installRawStyle [

	super installRawStyle.
	self padding: (BlInsets
			 horizontal: (self valueOfTokenNamed: #'padding-content-H')
			 vertical: (self valueOfTokenNamed: #'padding-content-V'))
]

{ #category : #accessing }
ToSelectListNode >> select [

	^ select
]

{ #category : #accessing }
ToSelectListNode >> select: aSelect [

	select := aSelect
]

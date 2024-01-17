Class {
	#name : #ToSelectListNode,
	#superclass : #ToNode,
	#category : #'Toplo-Widget-Select-Node'
}

{ #category : #skin }
ToSelectListNode >> installRawStyle [

	super installRawStyle.
	self padding: (BlInsets
			 horizontal: (self tokenValueNamed: #'padding-content-H')
			 vertical: (self tokenValueNamed: #'padding-content-V'))
]

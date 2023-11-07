Class {
	#name : 'ToSelectInnerButton',
	#superclass : 'ToMenu',
	#category : 'Toplo-Widget-Select',
	#package : 'Toplo-Widget-Select'
}

{ #category : 'skin' }
ToSelectInnerButton >> installRawStyle [

	super installRawStyle.
	self beLabelFirst.
	self flexible: true.
	self hMatchParent.
	self icon: (ToImage inner: (Smalltalk ui icons iconNamed: #bottom))	
]

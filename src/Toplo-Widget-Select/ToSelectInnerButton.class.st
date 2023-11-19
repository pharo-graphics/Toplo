Class {
	#name : #ToSelectInnerButton,
	#superclass : #ToMenu,
	#category : 'Toplo-Widget-Select'
}

{ #category : #skin }
ToSelectInnerButton >> installRawStyle [

	super installRawStyle.
	self beLabelFirst.
	self flexible: true.
	self hMatchParent.
	self icon: (ToImage inner: (Smalltalk ui icons iconNamed: #bottom)).
	self iconDo: [ :ic | ic formColor: Color black ].

]

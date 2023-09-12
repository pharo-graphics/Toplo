Class {
	#name : #ToInheritedPropertyDef,
	#superclass : #ToPropertyDef,
	#category : #'Toplo-Theme-LookUpdater'
}

{ #category : #operating }
ToInheritedPropertyDef >> write: anPropertyValue to: anObject [

	| prop |
	anObject hasParent ifFalse: [ ^ self ].
	self halt.
	(prop := anObject parent lookUpSkinPropertyNamed: self name) ifNil: [ ^ self ].
	prop write: anPropertyValue to: anObject
]

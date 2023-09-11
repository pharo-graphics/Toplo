Class {
	#name : #ToSlotPropertyDefinition,
	#superclass : #ToPropertyDefinition,
	#category : #'Toplo-Theme-Look'
}

{ #category : #accessing }
ToSlotPropertyDefinition class >> name: aName [ 

	^ self new
		  name: aName;
		  yourself
]

{ #category : #operating }
ToSlotPropertyDefinition >> read: anObject [

	^ anObject readSlotNamed: self name
]

{ #category : #operating }
ToSlotPropertyDefinition >> write: aPropertyValue to: anObject [

	anObject writeSlotNamed: self name value: aPropertyValue
]

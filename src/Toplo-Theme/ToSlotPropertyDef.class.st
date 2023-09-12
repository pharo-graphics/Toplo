Class {
	#name : #ToSlotPropertyDef,
	#superclass : #ToPropertyDef,
	#category : #'Toplo-Theme-Look'
}

{ #category : #accessing }
ToSlotPropertyDef class >> name: aName [ 

	^ self new
		  name: aName;
		  yourself
]

{ #category : #operating }
ToSlotPropertyDef >> read: anObject [

	^ anObject readSlotNamed: self name
]

{ #category : #operating }
ToSlotPropertyDef >> write: aPropertyValue to: anObject [

	anObject writeSlotNamed: self name value: aPropertyValue
]

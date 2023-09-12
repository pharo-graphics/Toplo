Class {
	#name : #ToExplicitPropertyDef,
	#superclass : #ToPropertyDef,
	#instVars : [
		'writer',
		'reader'
	],
	#category : #'Toplo-Theme-LookUpdater'
}

{ #category : #'instance creation' }
ToExplicitPropertyDef class >> name: aName reader: aReadValuable writer: aWriteValuable [

	^ self new
		  name: aName;
		  reader: aReadValuable;
		  writer: aWriteValuable;
		  yourself
]

{ #category : #operating }
ToExplicitPropertyDef >> read: anObject [

	^ self reader value: anObject
]

{ #category : #accessing }
ToExplicitPropertyDef >> reader [

	^ reader
]

{ #category : #accessing }
ToExplicitPropertyDef >> reader: aValuable [

	reader := aValuable
]

{ #category : #operating }
ToExplicitPropertyDef >> write: anPropertyValue to: anObject [

	self writer value: anObject value: anPropertyValue
]

{ #category : #accessing }
ToExplicitPropertyDef >> writer [

	^ writer
]

{ #category : #accessing }
ToExplicitPropertyDef >> writer: aValuable [

	writer := aValuable
]

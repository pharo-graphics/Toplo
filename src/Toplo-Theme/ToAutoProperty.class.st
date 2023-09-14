Class {
	#name : #ToAutoProperty,
	#superclass : #ToPseudoProperty,
	#instVars : [
		'valueProvider',
		'lookEventClasses'
	],
	#category : #'Toplo-Theme-LookUpdater'
}

{ #category : #'instance creation' }
ToAutoProperty class >> name: aName reader: aReadValuable writer: aWriteValuable value: aProviderValuable events: aLookEventClassCollection [

	^ self new
		  name: aName;
		  reader: aReadValuable;
		  writer: aWriteValuable;
		  valueProvider: aProviderValuable;
		  lookEventClasses: aLookEventClassCollection;
		  yourself
]

{ #category : #accessing }
ToAutoProperty >> lookEventClasses [

	^ lookEventClasses 
]

{ #category : #accessing }
ToAutoProperty >> lookEventClasses: aLookEventCollection [

	lookEventClasses := aLookEventCollection
]

{ #category : #operating }
ToAutoProperty >> receiveLookEvent: aLookEvent from: aPropertySubscription [
	
	| target rawValue valueWriter |
	self valueProvider ifNil: [ ^ Error signal: 'An auto property must have a value provider valuable' ].
	target := aLookEvent currentTarget.
	rawValue := self valueProvider value: target value: aLookEvent.
	valueWriter := aPropertySubscription valueWriter.
	valueWriter write: rawValue to: target
]

{ #category : #operating }
ToAutoProperty >> setAsPropertyIn: aLookUpdater [

	aLookUpdater addSubscription: (ToAutoPropertySubscription new
		  property: self;
		  yourself)
]

{ #category : #accessing }
ToAutoProperty >> valueProvider [

	^ valueProvider
]

{ #category : #accessing }
ToAutoProperty >> valueProvider: aValuable [

	valueProvider := aValuable
]

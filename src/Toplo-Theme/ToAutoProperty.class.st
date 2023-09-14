Class {
	#name : #ToAutoProperty,
	#superclass : #ToPseudoProperty,
	#instVars : [
		'valueProvider'
	],
	#category : #'Toplo-Theme-LookUpdater'
}

{ #category : #'instance creation' }
ToAutoProperty class >> name: aName reader: aReadValuable writer: aWriteValuable valueProvider: aProviderValuable [

	^ self new
		  name: aName;
		  reader: aReadValuable;
		  writer: aWriteValuable;
		  valueProvider: aProviderValuable;
		  yourself
]

{ #category : #operating }
ToAutoProperty >> receiveLookEvent: aLookEvent from: aPropertySubscription [
	
	| target rawValue valueWriter |
	self valueProvider ifNil: [ ^ Error signal: 'An auto property must have a value provider valuable' ].
	target := aLookEvent currentTarget.
	rawValue := self valueProvider value: target.
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

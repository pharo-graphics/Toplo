Class {
	#name : #ToExamplesSmokeTest,
	#superclass : #BlParameterizedHostTest,
	#instVars : [
		'previousPreferredHost',
		'exampleSelector'
	],
	#classVars : [
		'Enabled'
	],
	#category : #'Toplo-Examples-Support'
}

{ #category : #settings }
ToExamplesSmokeTest class >> enabled [

	^ Enabled ifNil: [ Enabled := true ]
]

{ #category : #settings }
ToExamplesSmokeTest class >> enabled: aBoolean [

	Enabled := aBoolean
]

{ #category : #accessing }
ToExamplesSmokeTest class >> exampleSelectors [

	^ (self targetClass class selectors select: [ :each |
		   (each beginsWith: 'example') and: [
			   (self ignoredExampleSelectors includes: each) not ] ])
		  asSortedCollection
]

{ #category : #accessing }
ToExamplesSmokeTest class >> ignoredExampleSelectors [

	^ #( )
]

{ #category : #testing }
ToExamplesSmokeTest class >> isAbstract [

	^ self == ToExamplesSmokeTest
]

{ #category : #settings }
ToExamplesSmokeTest class >> settingsOn: aBuilder [

	<systemsettings>
	(aBuilder setting: #enabled)
		parent: #Toplo;
		label: 'Enable Smoke tests';
		default: true;
		target: self;
		description: 'Enable or disable ToExamplesSmokeTest and its subclasses'
]

{ #category : #accessing }
ToExamplesSmokeTest class >> targetClass [

	^ nil
]

{ #category : #'building suites' }
ToExamplesSmokeTest class >> testParameters [

	| matrix |
	matrix := super testParameters.
	self isAbstract ifTrue: [ ^ matrix ].
	self exampleSelectors ifEmpty: [ ^ matrix ].

	^ matrix * (ParametrizedTestMatrix new
		  forSelector: #exampleSelector
		  addOptions: self exampleSelectors)
]

{ #category : #accessing }
ToExamplesSmokeTest >> exampleSelector [

	^ exampleSelector
]

{ #category : #accessing }
ToExamplesSmokeTest >> exampleSelector: aSymbol [

	exampleSelector := aSymbol
]

{ #category : #running }
ToExamplesSmokeTest >> setUp [

	super setUp.

	self class enabled ifFalse: [
		self skip: 'Smoke tests are disabled via system settings' ].

	previousPreferredHost := BlHostRegistry default preferredHost.
	BlHostRegistry default preferredHost: host
]

{ #category : #accessing }
ToExamplesSmokeTest >> targetClass [

	^ self class targetClass
]

{ #category : #running }
ToExamplesSmokeTest >> tearDown [

	BlHostRegistry default preferredHost: previousPreferredHost.

	super tearDown
]

{ #category : #tests }
ToExamplesSmokeTest >> testSmoke [

	[
		self targetClass perform: exampleSelector.
		self settleNonInitialSpaces
	] ensure: [
		self closeNonInitialSpaces ]
]

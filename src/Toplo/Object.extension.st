Extension { #name : #Object }

{ #category : #'*Toplo' }
Object >> asStateUpdater [

	^ ToStateUpdater new value: self
]

{ #category : #'*Toplo' }
Object >> asStateValue [

	^ ToStateValue new value: self
]

{ #category : #'*Toplo' }
Object >> deprecatedInsteadOf: aString use: aStringToUse [
	"Automatically tranform the deprecated call"

	| rule |
	aString numArgs > 1 ifTrue: [ self error: 'Zero one argument allowed' ].
	rule := aString numArgs isZero 
		ifTrue: [('`@receiver ', aString) -> ('`@receiver ', aStringToUse )] 
		ifFalse: [('`@receiver ', aString, ' `@arg') -> ('`@receiver ', aStringToUse, ' `@arg' )].
	
	Deprecation new
		context: thisContext sender;
		explanation: 'Deprecated';
		rule: rule;
		transform
]

{ #category : #'*Toplo' }
Object >> deprecatedTransformWith: aRule [
	"Automatically tranform the deprecated call"

	Deprecation new
		context: thisContext sender;
		explanation: 'Deprecated';
		rule: aRule;
		transform
]

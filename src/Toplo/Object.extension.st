Extension { #name : #Object }

{ #category : #'*Toplo' }
Object >> asElementAdapter [ 

	Error signal: 'Only valuable can be converted as an element adapter'
]

{ #category : #'*Toplo' }
Object >> asPropertyAdapterFor: aPropertyDefinition [

	^ ToPropertyAdapter new
		  value: self;
		  property: aPropertyDefinition;
		  yourself
]

{ #category : #'*Toplo' }
Object >> asStateUpdater [ 

	Error signal: 'Only valuable can be converted as an updater'
]

{ #category : #'*Toplo' }
Object >> asStateValue [

	^ ToStateValueDep new value: self
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

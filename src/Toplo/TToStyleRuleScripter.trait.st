Trait {
	#name : #TToStyleRuleScripter,
	#category : #'Toplo-Core-StyleSheet'
}

{ #category : #'t - stylesheet scripter - syntactic sugar' }
TToStyleRuleScripter >> action: aValuable [ 

	 ^ ToActionSelector new action: aValuable 
]

{ #category : #'t - stylesheet scripter - syntactic sugar' }
TToStyleRuleScripter >> any [

	^ self lookEventListenerHolder newUniversalSelector
]

{ #category : #'t - stylesheet scripter' }
TToStyleRuleScripter >> do: aValuable [

	self when: nil do: aValuable
]

{ #category : #'t - stylesheet scripter - syntactic sugar' }
TToStyleRuleScripter >> haveExactHeight [

	^ self action: [ :e | e constraints vertical resizer isExact ]
]

{ #category : #'t - stylesheet scripter - syntactic sugar' }
TToStyleRuleScripter >> haveExactWidth [

	^ self action: [ :e | e constraints horizontal resizer isExact]

]

{ #category : #'t - stylesheet scripter - syntactic sugar' }
TToStyleRuleScripter >> id: aSymbol [

 	^ ToIdSelector new id: aSymbol

]

{ #category : #'t - stylesheet scripter' }
TToStyleRuleScripter >> lookEventListenerHolder [ 

	^ self explicitRequirement 
]

{ #category : #'t - stylesheet scripter' }
TToStyleRuleScripter >> select: aStyleSelector style: aBlock [

	self lookEventListenerHolder pushStyleRuleFor: aStyleSelector styleWith: aBlock
]

{ #category : #'t - stylesheet scripter' }
TToStyleRuleScripter >> supplement: aProperty with: aValuableOrObject [

	self
		when: nil
		supplement: aProperty
		with: aValuableOrObject
]

{ #category : #'t - stylesheet scripter - syntactic sugar' }
TToStyleRuleScripter >> type: aClass [

	^ ToTypeSelector new type: aClass
]

{ #category : #'t - stylesheet scripter' }
TToStyleRuleScripter >> when: aLookEventClass do: aValuable [

	self lookEventListenerHolder addLookEventListener: (ToLookEventAction new
			 eventClass: aLookEventClass;
			 action: aValuable;
			 yourself)
]

{ #category : #'t - stylesheet scripter' }
TToStyleRuleScripter >> when: aLookEventClass supplement: aWritableProperty with: aValuableOrObject [

	self lookEventListenerHolder addLookEventListener: (ToPropertyWriter new
			 eventClass: aLookEventClass;
			 property: aWritableProperty;
			 value: aValuableOrObject;
			 supplement: true;
			 yourself)
]

{ #category : #'t - stylesheet scripter' }
TToStyleRuleScripter >> when: aLookEventClass supplement: aWriteableProperty with: aValuableOrObject animation: aPropertyAnimation [

	self lookEventListenerHolder addLookEventListener:
		(ToPropertyWriter new
			 eventClass: aLookEventClass;
			 property: aWriteableProperty;
			 value: aValuableOrObject;
			 animation: aPropertyAnimation;
			 supplement: true;
			 yourself)
]

{ #category : #'t - stylesheet scripter' }
TToStyleRuleScripter >> when: aLookEventClass write: aProperty with: aValuableOrObject [

	self
		when: aLookEventClass
		write: aProperty
		with: aValuableOrObject
		animation: nil
]

{ #category : #'t - stylesheet scripter' }
TToStyleRuleScripter >> when: aLookEventClass write: aWriteableProperty with: aValuableOrObject animation: aPropertyAnimation [

	self lookEventListenerHolder addLookEventListener: (ToPropertyWriter new
			 eventClass: aLookEventClass;
			 property: aWriteableProperty;
			 value: aValuableOrObject;
			 animation: aPropertyAnimation;
			 supplement: false;
			 yourself)
]

{ #category : #'t - stylesheet scripter - syntactic sugar' }
TToStyleRuleScripter >> withChild: aSelector [

	^ ToChildSelector new
		  left: self any;
		  right: aSelector;
		  yourself
]

{ #category : #'t - stylesheet scripter - syntactic sugar' }
TToStyleRuleScripter >> withChild: aSelector atDepth: anInteger [

	^ ToChildSelector new
		  depth: anInteger;
		  left: self any;
		  right: aSelector;
		  yourself
]

{ #category : #'t - stylesheet scripter - syntactic sugar' }
TToStyleRuleScripter >> withParent: aSelector [

	^ ToParentSelector new
		  left: self any;
		  right: aSelector;
		  yourself
]

{ #category : #'t - stylesheet scripter - syntactic sugar' }
TToStyleRuleScripter >> withParent: aSelector atDepth: anInteger [

	^ ToParentSelector new
		depth: anInteger;
		  left: self any;
		  right: aSelector;
		  yourself
]

{ #category : #'t - stylesheet scripter' }
TToStyleRuleScripter >> write: aProperty with: aValue [

	self
		when: nil
		write: aProperty
		with: aValue
		animation: nil
]

{ #category : #'t - stylesheet scripter' }
TToStyleRuleScripter >> write: aProperty withAll: anArrayOfEventValueAssociations [

	anArrayOfEventValueAssociations do: [ :assoc |
		| event value |
		event := assoc key.
		value := assoc value.
		self when: event write: aProperty with: value ]
]

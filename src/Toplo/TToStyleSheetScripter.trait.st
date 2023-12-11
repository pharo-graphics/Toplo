Trait {
	#name : 'TToStyleSheetScripter',
	#category : 'Toplo-Core-StyleSheet',
	#package : 'Toplo',
	#tag : 'Core-StyleSheet'
}

{ #category : 't - stylesheet scripter - syntactic sugar' }
TToStyleSheetScripter >> action: aValuable [ 

	 ^ ToActionSelector new action: aValuable 
]

{ #category : 't - stylesheet scripter - syntactic sugar' }
TToStyleSheetScripter >> any [

	^ self propertyWritersHolder newUniversalSelector
]

{ #category : 't - stylesheet scripter - syntactic sugar' }
TToStyleSheetScripter >> haveExactHeight [

	^ self action: [ :e | e constraints vertical resizer isExact ]
]

{ #category : 't - stylesheet scripter - syntactic sugar' }
TToStyleSheetScripter >> haveExactWidth [

	^ self action: [ :e | e constraints horizontal resizer isExact]

]

{ #category : 't - stylesheet scripter - syntactic sugar' }
TToStyleSheetScripter >> id: aSymbol [

 	^ ToIdSelector new id: aSymbol

]

{ #category : 't - stylesheet scripter' }
TToStyleSheetScripter >> propertyWritersHolder [ 

	^ self explicitRequirement 
]

{ #category : 't - stylesheet scripter' }
TToStyleSheetScripter >> select: aStyleSelector style: aBlock [

	self propertyWritersHolder pushStyleRuleFor: aStyleSelector styleWith: aBlock
]

{ #category : 't - stylesheet scripter' }
TToStyleSheetScripter >> supplement: aProperty with: aValuableOrObject [

	self
		when: nil
		supplement: aProperty
		with: aValuableOrObject
]

{ #category : 't - stylesheet scripter - syntactic sugar' }
TToStyleSheetScripter >> type: aClass [

	^ ToTypeSelector new type: aClass
]

{ #category : 't - stylesheet scripter' }
TToStyleSheetScripter >> when: aLookEventClass supplement: aWritableProperty with: aValuableOrObject [

	self propertyWritersHolder addPropertyWriter: (ToPropertyWriter new
			 eventClass: aLookEventClass;
			 property: aWritableProperty;
			 value: aValuableOrObject;
			 supplement: true;
			 yourself)
]

{ #category : 't - stylesheet scripter' }
TToStyleSheetScripter >> when: aLookEventClass write: aProperty with: aValuableOrObject [

	self
		when: aLookEventClass
		write: aProperty
		with: aValuableOrObject
		animation: nil
]

{ #category : 't - stylesheet scripter' }
TToStyleSheetScripter >> when: aLookEventClass write: aWriteableProperty with: aValuableOrObject animation: aPropertyAnimation [

	self propertyWritersHolder addPropertyWriter: (ToPropertyWriter new
			 eventClass: aLookEventClass;
			 property: aWriteableProperty;
			 value: aValuableOrObject;
			 animation: aPropertyAnimation;
			 supplement: false;
			 yourself)
]

{ #category : 't - stylesheet scripter - syntactic sugar' }
TToStyleSheetScripter >> withChild: aSelector [

	^ ToChildSelector new
		  left: self any;
		  right: aSelector;
		  yourself
]

{ #category : 't - stylesheet scripter - syntactic sugar' }
TToStyleSheetScripter >> withChild: aSelector atDepth: anInteger [

	^ ToChildSelector new
		  depth: anInteger;
		  left: self any;
		  right: aSelector;
		  yourself
]

{ #category : 't - stylesheet scripter - syntactic sugar' }
TToStyleSheetScripter >> withParent: aSelector [

	^ ToParentSelector new
		  left: self any;
		  right: aSelector;
		  yourself
]

{ #category : 't - stylesheet scripter - syntactic sugar' }
TToStyleSheetScripter >> withParent: aSelector atDepth: anInteger [

	^ ToParentSelector new
		depth: anInteger;
		  left: self any;
		  right: aSelector;
		  yourself
]

{ #category : 't - stylesheet scripter' }
TToStyleSheetScripter >> write: aProperty with: aValue [

	self
		when: nil
		write: aProperty
		with: aValue
		animation: nil
]

{ #category : 't - stylesheet scripter' }
TToStyleSheetScripter >> write: aProperty withAll: anArrayOfEventValueAssociations [

	anArrayOfEventValueAssociations do: [ :assoc |
		| event value |
		event := assoc key.
		value := assoc value.
		self when: event write: aProperty with: value ]
]

Class {
	#name : 'ToStyleSheet',
	#superclass : 'Object',
	#traits : 'TToStyleRulesHolder + TToWritablePropertyIndexHolder',
	#classTraits : 'TToStyleRulesHolder classTrait + TToWritablePropertyIndexHolder classTrait',
	#instVars : [
		'styleRules',
		'inherits',
		'writablePropertyIndex'
	],
	#category : 'Toplo-Core-StyleSheet',
	#package : 'Toplo',
	#tag : 'Core-StyleSheet'
}

{ #category : 'class initialization' }
ToStyleSheet class >> defaultWritablePropertyList [
	" skin managing need a list of unique writeable properties. "

	^ {
		  (ToFeatureProperty name: #mouseCursor).
		  (ToFeatureProperty name: #background).
		  (ToFeatureProperty name: #geometry).
		  (ToFeatureProperty name: #border).
		  (ToFeatureProperty name: #size).
		  (ToFeatureProperty name: #height).
		  (ToFeatureProperty name: #width).
		  (ToFeatureProperty name: #margin).
		  (ToFeatureProperty name: #padding).
		  (ToFeatureProperty name: #icon).
		  (ToFeatureProperty name: #label).
		  (ToFeatureProperty name: #justified).

			"buttons"
			(ToPseudoProperty new name: #'button-label-text-foreground';
			   writer: [ :e :v |
				   e label ifNotNil:[ 
						e label text attributes: { (BlTextForegroundAttribute paint: v) }.
				  	 	e label textChanged]
				]).
			
			"others"
		  (ToPseudoProperty name: #'background-color'
			   reader: [ :e | e background paint ifNotNil: [ :f | f color ] ifNil:[ Color transparent ] ]
			   writer: [ :e :v | e background: v ]).
			
		  (ToPseudoProperty  name: #'border-with-builder'
			   reader: [ :e | e border ]
			   writer: [ :e :v | e border: v build ]).
			
		  (ToPseudoProperty new name: #'text-attributes-with-builder';
			   writer: [ :e :v |
				   e text attributes: v attributes.
				   e textChanged ]).
			
		  (ToPseudoProperty new name: #'label-text-background';
			   writer: [ :e :v |
				   e text attributes: { (BlTextBackgroundAttribute paint: v) }.
				   e textChanged ]).
			
		  (ToPseudoProperty new name: #'label-text-foreground';
			   writer: [ :e :v |
				   e text attributes: { (BlTextForegroundAttribute paint: v) }.
				   e textChanged ]).
			
		  (ToFeatureProperty new name: #innerImage).
		
		  (ToFeatureProperty new name: #iconImage).
		
		  (ToPseudoProperty new name: #'image-inner-form-color';
			   writer: [ :e :v |
				   e
					   withInnerFormDo: [ :form |
						   e innerImage:
								   (form collectColors: [ :color | v alpha: color alpha ]) ]
					   ifNone: [  ] ]).
				
		  (ToFeatureProperty name: #layout).
		
		  (ToPseudoProperty name: #'layout-direction'
			   reader: [ :e | e layout direction ]
			   writer: [ :e :v | e layout direction: v ]).
			
		  (ToPseudoProperty name: #'layout-orientation'
			   reader: [ :e | e layout orientation ]
			   writer: [ :e :v | e layout orientation: v ]).
			
		  (ToPseudoProperty name: #'layout-interspace'
			   reader: [ :e | e layout interspace ]
			   writer: [ :e :v | e layout interspace: v ]).
			
		  (ToPseudoProperty name: #'layout-constraints'
			   reader: [ :e | e constraints ]
			   writer: [ :e :v | v value: e constraints ]) }
]

{ #category : 'syntactic sugar' }
ToStyleSheet >> action: aValuable [

 	^ ToActionSelector new action: aValuable; yourself

]

{ #category : 'syntactic sugar' }
ToStyleSheet >> any [

 	^ ToUniversalSelector new

]

{ #category : 'initialization' }
ToStyleSheet >> defaultStyleRules [

	^ #()
]

{ #category : 't - writable property index holder' }
ToStyleSheet >> defaultWritablePropertyList [
	" skin managing need a list of unique writeable properties. "

	^ self class defaultWritablePropertyList
]

{ #category : 'syntactic sugar' }
ToStyleSheet >> haveExactHeight [

	^ self action: [ :e | e constraints vertical resizer isExact ]
]

{ #category : 'syntactic sugar' }
ToStyleSheet >> haveExactWidth [

	^ self action: [ :e | e constraints horizontal resizer isExact]

]

{ #category : 'syntactic sugar' }
ToStyleSheet >> id: aSymbol [

 	^ ToIdSelector new id: aSymbol

]

{ #category : 'accessing' }
ToStyleSheet >> inherits [

	^ inherits
]

{ #category : 'accessing' }
ToStyleSheet >> inherits: aBoolean [

	inherits := aBoolean
]

{ #category : 'initialization' }
ToStyleSheet >> initialize [ 

	super initialize.
	self rawStyleRules: self defaultStyleRules.
	inherits := true
]

{ #category : 'initialization' }
ToStyleSheet >> onInstalledIn: anElement [

	anElement requestNewSkinRecursively

]

{ #category : 'initialization' }
ToStyleSheet >> onUnInstalledIn: anElement [

]

{ #category : 't - style rules holder' }
ToStyleSheet >> rawStyleRules [

	^ styleRules 
]

{ #category : 't - style rules holder' }
ToStyleSheet >> rawStyleRules: aStyleRuleCollection [

	styleRules := aStyleRuleCollection
]

{ #category : 't - writable property index holder' }
ToStyleSheet >> rawWritablePropertyIndex [

	^ writablePropertyIndex 
]

{ #category : 't - writable property index holder' }
ToStyleSheet >> rawWritablePropertyIndex: aPropertyIndex [

	writablePropertyIndex := aPropertyIndex
]

{ #category : 'syntactic sugar' }
ToStyleSheet >> type: aClass [

	^ ToTypeSelector new type: aClass
]

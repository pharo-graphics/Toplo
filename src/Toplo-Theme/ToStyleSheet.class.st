Class {
	#name : 'ToStyleSheet',
	#superclass : 'Object',
	#traits : 'TToStyleRuleHolder',
	#classTraits : 'TToStyleRuleHolder classTrait',
	#instVars : [
		'styleRules',
		'inherits',
		'writablePropertyIndex',
		'stampIndex'
	],
	#category : 'Toplo-Theme-StyleSheet',
	#package : 'Toplo-Theme',
	#tag : 'StyleSheet'
}

{ #category : 'running' }
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

		  (ToPseudoProperty
			   name: #'background-color'
			   reader: [ :e | e background paint color ]
			   writer: [ :e :v | e background: v ]).
		  (ToPseudoProperty
			   name: #'border-with-builder'
			   reader: [ :e | e border ]
			   writer: [ :e :v | e border: v build ]).
		  (ToPseudoProperty new
			   name: #'text-attributes-with-builder';
			   writer: [ :e :v |
				   e text attributes: v attributes.
				   e textChanged ]).
		  (ToPseudoProperty new
			   name: #'label-text-background';
			   writer: [ :e :v |
				   e text attributes: { (BlTextBackgroundAttribute paint: v) }.
				   e textChanged ]).
		  (ToPseudoProperty new
			   name: #'label-text-foreground';
			   writer: [ :e :v |
				   e text attributes: { (BlTextForegroundAttribute paint: v) }.
				   e textChanged ]).
		  (ToFeatureProperty new name: #innerImage).
		  (ToFeatureProperty new name: #iconImage).
		  (ToPseudoProperty new
			   name: #'image-inner-form-color';
			   writer: [ :e :v |
				   e
					   withInnerFormDo: [ :form |
						   e innerImage:
								   (form collectColors: [ :color | v alpha: color alpha ]) ]
					   ifNone: [  ] ]).
		  (ToFeatureProperty name: #layout).
		  (ToPseudoProperty
			   name: #'layout-direction'
			   reader: [ :e | e layout direction ]
			   writer: [ :e :v | e layout direction: v ]).
		  (ToPseudoProperty
			   name: #'layout-orientation'
			   reader: [ :e | e layout orientation ]
			   writer: [ :e :v | e layout orientation: v ]).
		  (ToPseudoProperty
			   name: #'layout-interspace'
			   reader: [ :e | e layout interspace ]
			   writer: [ :e :v | e layout interspace: v ]).
		  (ToPseudoProperty
			   name: #'layout-constraints'
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

{ #category : 'accessing' }
ToStyleSheet >> defaultStampList: aStyleStampCollection [

	stampIndex := self newStampIndexFromStampList: aStyleStampCollection
]

{ #category : 'initialization' }
ToStyleSheet >> defaultStyleRules [

	^ #()
]

{ #category : 'syntactic sugar' }
ToStyleSheet >> haveExactHeight [

	^ self action: [ :e | e constraints vertical resizer isExact]

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
	styleRules := self defaultStyleRules.
	inherits := true
]

{ #category : 'initialization' }
ToStyleSheet >> newStampIndexFromStampList: aStyleStampCollection [

	^ ToPropertyIndex new addAllProperties: aStyleStampCollection; yourself.
]

{ #category : 'initialization' }
ToStyleSheet >> newWritablePropertyIndex [

	^ ToPropertyIndex new addAllProperties: self writablePropertyList; yourself.
]

{ #category : 'initialization' }
ToStyleSheet >> onInstalledIn: anElement [

	anElement requestSkinRecursively

]

{ #category : 'initialization' }
ToStyleSheet >> onUnInstalledIn: anElement [

]

{ #category : 'syntactic sugar' }
ToStyleSheet >> property: aSymbol [

	^ self writablePropertyNamed: aSymbol
]

{ #category : 't - style rule holder - accessing' }
ToStyleSheet >> rawStyleRules [

	^ styleRules 
]

{ #category : 't - style rule holder - accessing' }
ToStyleSheet >> rawStyleRules: aStyleRuleCollection [

	styleRules := aStyleRuleCollection
]

{ #category : 'accessing' }
ToStyleSheet >> stampIndex [

	^ stampIndex 
]

{ #category : 'accessing' }
ToStyleSheet >> stampNamed: aName [

	^ self stampIndex ifNotNil: [ :si | si propertyNamed: aName ]
]

{ #category : 'syntactic sugar' }
ToStyleSheet >> type: aClass [

	^ ToTypeSelector new type: aClass
]

{ #category : 'accessing' }
ToStyleSheet >> writablePropertyIndex [

	^ writablePropertyIndex ifNil: [ writablePropertyIndex := self newWritablePropertyIndex ]
]

{ #category : 'accessing' }
ToStyleSheet >> writablePropertyList [
	" skin managing need a list of unique writeable properties. "

	^ self class defaultWritablePropertyList
]

{ #category : 'accessing' }
ToStyleSheet >> writablePropertyNamed: aName [

	^ self writablePropertyIndex propertyNamed: aName
]

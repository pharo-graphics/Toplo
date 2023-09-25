Class {
	#name : #ToStyleSheet,
	#superclass : #Object,
	#traits : 'TToStyleRuleHolder',
	#classTraits : 'TToStyleRuleHolder classTrait',
	#instVars : [
		'styleRules',
		'inherits',
		'writeablePropertyIndex',
		'elementTagIndex'
	],
	#category : #'Toplo-Theme-StyleSheet'
}

{ #category : #running }
ToStyleSheet class >> writeablePropertyList [
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
		  (ToFeatureProperty name: #extra).
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

{ #category : #'syntactic sugar' }
ToStyleSheet >> action: aValuable [

 	^ ToActionSelector new action: aValuable; yourself

]

{ #category : #'syntactic sugar' }
ToStyleSheet >> any [

 	^ ToUniversalSelector new

]

{ #category : #initialization }
ToStyleSheet >> defaultStyleRules [

	^ #()
]

{ #category : #'syntactic sugar' }
ToStyleSheet >> haveExactHeight [

	^ self action: [ :e | e constraints vertical resizer isExact]

]

{ #category : #'syntactic sugar' }
ToStyleSheet >> haveExactWidth [

	^ self action: [ :e | e constraints horizontal resizer isExact]

]

{ #category : #'syntactic sugar' }
ToStyleSheet >> id: aSymbol [

 	^ ToIdSelector new id: aSymbol

]

{ #category : #accessing }
ToStyleSheet >> inherits [

	^ inherits
]

{ #category : #accessing }
ToStyleSheet >> inherits: aBoolean [

	inherits := aBoolean
]

{ #category : #initialization }
ToStyleSheet >> initialize [ 

	super initialize.
	styleRules := self defaultStyleRules.	
	writeablePropertyIndex := ToPropertyIndex new recordAll: self writeablePropertyList; yourself.
	inherits := true
]

{ #category : #initialization }
ToStyleSheet >> onInstalledIn: anElement [

	writeablePropertyIndex := ToPropertyIndex new recordAll: anElement writeablePropertyList; yourself
]

{ #category : #initialization }
ToStyleSheet >> onUnInstalledIn: anElement [

]

{ #category : #'syntactic sugar' }
ToStyleSheet >> property: aSymbol [

	^ self writeablePropertyNamed: aSymbol
]

{ #category : #'t - style rule holder - accessing' }
ToStyleSheet >> rawStyleRules [

	^ styleRules 
]

{ #category : #'t - style rule holder - accessing' }
ToStyleSheet >> rawStyleRules: aStyleRuleCollection [

	styleRules := aStyleRuleCollection
]

{ #category : #accessing }
ToStyleSheet >> writeablePropertyIndex [

	^ writeablePropertyIndex
]

{ #category : #accessing }
ToStyleSheet >> writeablePropertyList [
	" skin managing need a list of unique writeable properties. "

	^ self class writeablePropertyList
]

{ #category : #accessing }
ToStyleSheet >> writeablePropertyNamed: aName [

	self writeablePropertyIndex ifNil: [ ToStyleSheetNotInstalledError signal ].
	^ self writeablePropertyIndex propertyNamed: aName
]

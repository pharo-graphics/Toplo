Class {
	#name : #ToStyleSheet,
	#superclass : #Object,
	#instVars : [
		'propertyIndex',
		'styleRules',
		'inherits'
	],
	#category : #'Toplo-Theme-StyleSheet'
}

{ #category : #accessing }
ToStyleSheet class >> propertyList [
	" skin managing need a list of unique property. See ToStyleSheet>>lookUpdatersFor: where properties are used in an IdentityDictionary"

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
		  (ToPseudoProperty
			   name: #'checkable-icon-image'
			   reader: [ :e | e icon innerImage ]
			   writer: [ :e :v |
				   v removeFromParent.
				   e iconImage: v.
				   e updateSkin ]).
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

{ #category : #accessing }
ToStyleSheet >> addStyleRule: aRule [

	styleRules := styleRules copyWith: aRule
]

{ #category : #accessing }
ToStyleSheet >> addStyleRules: aCollection [

	styleRules := styleRules copyWithAll: aCollection asArray
]

{ #category : #initialization }
ToStyleSheet >> defaultStyleRules [

	^ #()
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
	propertyIndex := self newPropertyIndex.
	styleRules := self defaultStyleRules.
	inherits := true
]

{ #category : #initialization }
ToStyleSheet >> newPropertyIndex [

	^ ToPropertyIndex new recordAll: self propertyList; yourself
]

{ #category : #accessing }
ToStyleSheet >> propertyIndex [

	^ propertyIndex
]

{ #category : #initialization }
ToStyleSheet >> propertyList [

	^ self class propertyList
]

{ #category : #accessing }
ToStyleSheet >> propertyNamed: aName [

	
	^ self propertyIndex ifNotNil: [ :pi | pi propertyNamed: aName]
]

{ #category : #accessing }
ToStyleSheet >> styleRules [ 

	^ styleRules
]

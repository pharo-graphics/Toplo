Class {
	#name : #ToStyleSheet,
	#superclass : #Object,
	#traits : 'TToStyleRuleScripter',
	#classTraits : 'TToStyleRuleScripter classTrait',
	#instVars : [
		'styleScript',
		'inherits',
		'writablePropertyIndex'
	],
	#category : #'Toplo-Core-StyleSheet'
}

{ #category : #'class initialization' }
ToStyleSheet class >> defaultWritablePropertyList [
	" skin managing need a list of unique writeable properties. "

	^ {
		  (ToFeatureProperty name: #text).
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
		  (ToFeatureProperty name: #outskirts).

		  "buttons"
		  (ToPseudoProperty new
			   name: #'button-label-text-foreground';
			   writer: [ :e :v |
				   e label ifNotNil: [
						   e label text attributes:
								   { (BlTextForegroundAttribute paint: v) } ] ]).

		  "others"
		  (ToPseudoProperty
			   name: #'border-with-builder'
			   reader: [ :e | e border ]
			   writer: [ :e :v | e border: v build ]).

		  (ToPseudoProperty new
			   name: #'text-attributes-with-builder';
			   writer: [ :e :v | e text attributes: v attributes ]).

		  (ToPseudoProperty new
			   name: #'label-text-background';
			   writer: [ :e :v |
				   e text attributes: { (BlTextBackgroundAttribute paint: v) } ]).

		  (ToPseudoProperty new
			   name: #'label-text-foreground';
			   writer: [ :e :v |
				   e text attributes: { (BlTextForegroundAttribute paint: v) } ]).

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

{ #category : #'accessing - writable properties' }
ToStyleSheet >> addWritableProperty: aProperty [

	self writablePropertyIndex addProperty: aProperty
]

{ #category : #initialization }
ToStyleSheet >> defaultScript [

	^ ToStyleScript new
]

{ #category : #'accessing - writable properties' }
ToStyleSheet >> defaultWritablePropertyList [
	" skin managing need a list of unique writeable properties. "

	^ self class defaultWritablePropertyList
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
	styleScript := self defaultScript.
	inherits := true.
	self initializeStyleRules.
]

{ #category : #initialization }
ToStyleSheet >> initializeStyleRules [
]

{ #category : #initialization }
ToStyleSheet >> onInstalledIn: anElement [

	anElement withAllChildrenBreadthFirstDo: [ :child |
		child requestNewSkin ]
]

{ #category : #initialization }
ToStyleSheet >> onUninstalledIn: anElement [

	anElement skinManagerDo: [ :sm |
		sm requestUninstallSkinRecursivelyIn: anElement ]
]

{ #category : #'accessing - writable properties' }
ToStyleSheet >> property: aSymbol [

	^ self writablePropertyNamed: aSymbol
]

{ #category : #'accessing - writable properties' }
ToStyleSheet >> rawWritablePropertyIndex [

	^ writablePropertyIndex 
]

{ #category : #'accessing - writable properties' }
ToStyleSheet >> rawWritablePropertyIndex: aPropertyIndex [

	writablePropertyIndex := aPropertyIndex
]

{ #category : #accessing }
ToStyleSheet >> script [

	^ styleScript
]

{ #category : #'t - stylesheet scripter' }
ToStyleSheet >> skinEventListenerHolder [ 

	^ self script
]

{ #category : #accessing }
ToStyleSheet >> styleRules [

	^ styleScript styleRules
]

{ #category : #'accessing - writable properties' }
ToStyleSheet >> writablePropertyIndex [

	^ self rawWritablePropertyIndex ifNil: [
		  self rawWritablePropertyIndex: ToPropertyIndex new.
		  self rawWritablePropertyIndex addAllProperties: self defaultWritablePropertyList.
		  self rawWritablePropertyIndex ]
]

{ #category : #'accessing - writable properties' }
ToStyleSheet >> writablePropertyNamed: aName [ 

	^ self writablePropertyIndex propertyNamed: aName
]

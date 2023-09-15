Class {
	#name : #ToStyleSheet,
	#superclass : #Object,
	#instVars : [
		'rules'
	],
	#classVars : [
		'PropertyIndex'
	],
	#category : #'Toplo-Theme-StyleSheet'
}

{ #category : #'class initialization' }
ToStyleSheet class >> initialize [ 

	PropertyIndex := self newPropertyIndex.
]

{ #category : #accessing }
ToStyleSheet class >> newLookUpdaterForPropertyName: aPropertyName [

	^ self propertyIndex newLookUpdaterForPropertyName: aPropertyName
]

{ #category : #'class initialization' }
ToStyleSheet class >> newPropertyIndex [

	^ ToPropertyIndex new recordAll: self propertyList; yourself
]

{ #category : #accessing }
ToStyleSheet class >> propertyIndex [

	^ PropertyIndex ifNil: [ PropertyIndex := self newPropertyIndex ]
]

{ #category : #accessing }
ToStyleSheet class >> propertyList [

	" skin managing need a list of unique property. See ToStyleSheet>>lookUpdatersFor: where properties are used in an IdentityDictionary"
	^ {
		  (ToInstVarProperty name: #mouseCursor).
		  (ToInstVarProperty name: #background).
		  (ToInstVarProperty name: #border).
		  (ToInstVarProperty name: #size).
		  (ToInstVarProperty name: #margin).
		  (ToInstVarProperty name: #padding).
		 	(ToInstVarProperty name: #icon).
		  (ToInstVarProperty name: #label).
		  (ToInstVarProperty name: #extra).

		  (ToPseudoProperty
			   name: #'background-color'
			   reader: [ :e | e background paint color ]
			   writer: [ :e :v | e background: v ]).
		  (ToPseudoProperty 
				name: #'border-with-builder'
				reader: [ :e | e border ]
				writer: [ :e :v | e border: v build]).
		  (ToPseudoProperty new 
				name: #'text-attributes-with-builder';
				writer: [ :e :v |
					e text attributes: v attributes.
					e textChanged ]).
		  (ToPseudoProperty new 
				name: #'label-text-background';
		  		writer: [ :e :v |
			  		e text attributes: { (BlTextBackgroundAttribute paint: v) }.
			  		e textChanged ] ).
		  (ToPseudoProperty new 
				name: #'label-text-foreground';
		  		writer: [ :e :v |
			  		e text attributes: { (BlTextForegroundAttribute paint: v) }.
			  		e textChanged ] ).
		  (ToInstVarProperty new name: #innerImage).
		  (ToPseudoProperty new
		        name: #'image-inner-form-color';
		        writer: [ :e :v |
			        e
				        withInnerFormDo: [ :form |
					        e innerImage: (form collectColors: [ :color | v alpha: color alpha ]) ]
				        ifNone: [  ] ]).
		  (ToPseudoProperty
			   name: #'checkable-icon-image'
			   reader: [ :e | e icon innerImage ]
				writer: [ :e :v | 
					v removeFromParent.
				   e iconImage: v ]).
		  (ToInstVarProperty name: #layout).
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
			   writer: [ :e :v | e layout interspace: v ]) }
]

{ #category : #accessing }
ToStyleSheet class >> propertyNamed: aName [

	^ self propertyIndex propertyNamed: aName
]

{ #category : #adding }
ToStyleSheet >> addRule: aStyleRule [

	rules add: aStyleRule 
]

{ #category : #initialization }
ToStyleSheet >> initialize [ 

	super initialize.
	rules := OrderedCollection new.

]

{ #category : #operating }
ToStyleSheet >> lookUpdatersFor: anElement [
	
	" for an element, several LookUpdater instances can be found. These LookUpdater instances 
	are found with #rawLookUpdatersFor:. After, for each property only the last LookUpdater is kept"

	| rawLooks selecter supplement |
	" get all LookUpdater instances for anElement "
	rawLooks := self rawLookUpdatersFor: anElement.
	" keep only the last for each property "
	selecter := IdentityDictionary new.
	supplement := OrderedCollection new.
	rawLooks do: [ :l | 
		l supplement ifTrue: [supplement add: l] ifFalse: [ selecter at: l property put: l ] ].
	^ selecter values, supplement
]

{ #category : #'accessing updaters' }
ToStyleSheet >> newLookUpdaterForPropertyName: aPropertyName [

	^ self class newLookUpdaterForPropertyName: aPropertyName
]

{ #category : #initialization }
ToStyleSheet >> newPropertyIndex [

	^ self class newPropertyIndex
]

{ #category : #accessing }
ToStyleSheet >> propertyIndex [

	^ self class propertyIndex
]

{ #category : #initialization }
ToStyleSheet >> propertyList [

	^ self class propertyList
]

{ #category : #'accessing updaters' }
ToStyleSheet >> propertyNamed: aName [

	^ self class propertyNamed: aName
]

{ #category : #operating }
ToStyleSheet >> rawLookUpdatersFor: anElement [

	^ Array streamContents: [ :str |
		  (self rulesFor: anElement) do: [ :r | str nextPutAll: r looks ] ]
]

{ #category : #accessing }
ToStyleSheet >> rules [

	^ rules
]

{ #category : #operating }
ToStyleSheet >> rulesFor: anElement [

	^ self rules select: [ :r | r canBeAppliedTo: anElement ]
]

{ #category : #operating }
ToStyleSheet >> skinFor: anElement [

	| looks skin |
	looks := self lookUpdatersFor: anElement.
	skin := ToWidgetSkin new.
	skin addAllLookUpdaters: looks.
	^ skin
]

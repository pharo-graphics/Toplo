Class {
	#name : #ToStyleSheet,
	#superclass : #Object,
	#instVars : [
		'rules',
		'propertyIndex'
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
		  (ToFeatureProperty new name: #innerImage).
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
			   writer: [ :e :v | e layout interspace: v ]) }
]

{ #category : #adding }
ToStyleSheet >> addRule: aStyleRule [

	rules := rules copyWith: aStyleRule
]

{ #category : #adding }
ToStyleSheet >> addRules: aStyleRuleCollection [

	rules := rules copyWithAll: aStyleRuleCollection
]

{ #category : #'syntactic sugar' }
ToStyleSheet >> class: aSymbol [

 	^ ToStyleClassSelector new styleClass: aSymbol

]

{ #category : #'syntactic sugar' }
ToStyleSheet >> classes: anArray [

 	^ ToStyleClassSelector new styleClasses: anArray

]

{ #category : #initialization }
ToStyleSheet >> initialize [

	super initialize.
	rules := #(  ).
	propertyIndex := self newPropertyIndex
]

{ #category : #initialization }
ToStyleSheet >> newPropertyIndex [

	^ ToPropertyIndex new recordAll: self propertyList; yourself
]

{ #category : #'syntactic sugar' }
ToStyleSheet >> property: aSymbol [

	^ self propertyNamed: aSymbol
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

	^ self propertyIndex propertyNamed: aName
]

{ #category : #operating }
ToStyleSheet >> rawWritersFor: anElement [

	^ Array streamContents: [ :str |
		  (self rulesFor: anElement) do: [ :r | str nextPutAll: r writers ] ]
]

{ #category : #accessing }
ToStyleSheet >> rules [

	^ rules
]

{ #category : #accessing }
ToStyleSheet >> rules: aStyleRuleCollection [

	rules := aStyleRuleCollection asArray
]

{ #category : #operating }
ToStyleSheet >> rulesFor: anElement [

	^ self rules select: [ :r | r canBeAppliedTo: anElement ]
]

{ #category : #'syntactic sugar' }
ToStyleSheet >> selectedWith: aSelector style: aBlock [

	^ ToStyleRule selectedWith: aSelector style: aBlock
]

{ #category : #'syntactic sugar' }
ToStyleSheet >> selectedWith: aSelector when: aLookEventClass style: aBlock [

	^ ToStyleRule selectedWith: aSelector when: aLookEventClass style: aBlock
]

{ #category : #operating }
ToStyleSheet >> skinFor: anElement [

	| writers skin |
	writers := self writersFor: anElement.
	skin := ToSkin new.
	skin writers: writers.
	^ skin
]

{ #category : #operating }
ToStyleSheet >> writersFor: anElement [
	" for an element, several writers can be found. These writers 
	are found with #rawWritersFor:. After, for each property only the last writers is kept"

	| rawWriters supplement uniqueWriters eventClassIndex |
	" get all subscriptions for anElement "
	rawWriters := self rawWritersFor: anElement.
	" keep only the last writers for each property except those which are declared as supplement"
	eventClassIndex := OrderPreservingIdentityDictionary new.
	supplement := OrderedCollection new.
	rawWriters do: [ :w |
		w supplement
			ifTrue: [ supplement add: w ]
			ifFalse: [
				| indexByProperty |
				indexByProperty := eventClassIndex
					                   at: w
					                   ifAbsentPut: [ IdentityDictionary new ].
				indexByProperty at: w property put: w ] ].
	uniqueWriters := Array streamContents: [ :str |
		                 eventClassIndex valuesDo: [ :indexByProperty |
			                 str nextPutAll: indexByProperty values ] ].
	^ uniqueWriters , supplement
]

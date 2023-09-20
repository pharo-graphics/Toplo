Class {
	#name : 'ToStyleSheetInterpreter',
	#superclass : 'Object',
	#instVars : [
		'styleSheetChain',
		'propertyIndex'
	],
	#category : 'Toplo-Theme-StyleSheet',
	#package : 'Toplo-Theme',
	#tag : 'StyleSheet'
}

{ #category : 'accessing' }
ToStyleSheetInterpreter class >> propertyList [
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
			   writer: [ :e :v | e layout interspace: v ]).
		  (ToPseudoProperty
			   name: #'layout-constraints'
			   reader: [ :e | e constraints ]
			   writer: [ :e :v | v value: e constraints ]) }
]

{ #category : 'syntactic sugar' }
ToStyleSheetInterpreter >> any [

 	^ ToUniversalSelector new

]

{ #category : 'syntactic sugar' }
ToStyleSheetInterpreter >> id: aSymbol [

 	^ ToIdSelector new id: aSymbol

]

{ #category : 'initialization' }
ToStyleSheetInterpreter >> initialize [ 

	super initialize.
	propertyIndex := self newPropertyIndex
]

{ #category : 'initialization' }
ToStyleSheetInterpreter >> newPropertyIndex [

	^ ToPropertyIndex new recordAll: self propertyList; yourself
]

{ #category : 'syntactic sugar' }
ToStyleSheetInterpreter >> property: aSymbol [

	^ self propertyNamed: aSymbol
]

{ #category : 'accessing' }
ToStyleSheetInterpreter >> propertyIndex [

	^ propertyIndex
]

{ #category : 'initialization' }
ToStyleSheetInterpreter >> propertyList [

	^ self class propertyList
]

{ #category : 'accessing' }
ToStyleSheetInterpreter >> propertyNamed: aName [

	^ self propertyIndex propertyNamed: aName
]

{ #category : 'accessing' }
ToStyleSheetInterpreter >> rawWritersFor: anElement [

	^ Array streamContents: [ :str |
		  self styleSheetChain reverseDo: [ :ss |
			  ss rules do: [ :rv | (rv value: self) do: [ :r |
				  (r canBeAppliedTo: anElement) ifTrue: [
					  str nextPutAll: r writers ] ] ] ] ]
]

{ #category : 'accessing' }
ToStyleSheetInterpreter >> skinFor: anElement [

	| writers skin |
	self halt.
	styleSheetChain := anElement styleSheetChain.
	writers := self writersFor: anElement.
	skin := ToSkin new.
	skin writers: writers.
	^ skin
]

{ #category : 'accessing' }
ToStyleSheetInterpreter >> styleSheetChain [

	^ styleSheetChain
]

{ #category : 'accessing' }
ToStyleSheetInterpreter >> writersFor: anElement [
	" for an element, several writers can be found. These writers 
	are found with #rawWritersFor:. After, for each property only the last writers is kept"

	| rawWriters supplement uniqueWriters eventClassIndex |
	
	" get all subscriptions for anElement "
	rawWriters := self rawWritersFor: anElement.
	
	" keep only the last writers for each property except those which are declared as supplement"
	eventClassIndex := IdentityDictionary new.
	supplement := OrderedCollection new.
	
	rawWriters do: [ :w |
		w supplement
			ifTrue: [ supplement add: w ]
			ifFalse: [
				| indexByProperty |
				indexByProperty := eventClassIndex
					                   at: w eventClass
					                   ifAbsentPut: [ IdentityDictionary new ].
				indexByProperty at: w property put: w ] ].
		
	uniqueWriters := Array streamContents: [ :str |
		                 eventClassIndex valuesDo: [ :indexByProperty |
			                 str nextPutAll: indexByProperty values ] ].
	
	^ Array streamContents: [:str | 
			str nextPutAll: (uniqueWriters sort: [ :a :b | a property name < b property name ]).
	  		str nextPutAll: supplement ]
]

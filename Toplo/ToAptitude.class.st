Class {
	#name : #ToAptitude,
	#superclass : #ToActor,
	#instVars : [
		'changes'
	],
	#category : #'Toplo-Editor-Core'
}

{ #category : #'api - composition' }
ToAptitude class >> + anotherLook [
	^ self asLook + anotherLook
]

{ #category : #'api - composition' }
ToAptitude class >> - anotherLook [
	^ self asLook - anotherLook
]

{ #category : #'api - composition' }
ToAptitude class >> asLook [
	^ self new
]

{ #category : #'api - composition' }
ToAptitude >> + anotherLook [
	self add: anotherLook asLook
]

{ #category : #'api - composition' }
ToAptitude >> - aLookClass [
	| toBeRemoved |
	self
		assert: [ aLookClass isClass ]
		description: [ 'It is only possible to remove a look by its type (class) using this API' ].

	toBeRemoved := actors select: [ :eachLook | eachLook class = aLookClass ].
	toBeRemoved reverseDo: [ :eachLook | self remove: eachLook ].
	actors do: [ :eachLook | eachLook - aLookClass ]
]

{ #category : #'api - composition' }
ToAptitude >> add: aBrLook [
	"Add a given look instance if it does not exist already"
	| aLookInstance |

	aLookInstance := aBrLook asLook.
	
	(actors includes: aLookInstance)
		ifTrue: [ ^ self ].

	actors := actors copyWith: aLookInstance.

	self widgetDo: [ :anElement | aLookInstance onInstalledIn: anElement ]
]

{ #category : #'api - composition' }
ToAptitude >> addAll: aCollectionOfLooks [
	aCollectionOfLooks do: [ :aLook | self add: aLook ]
]

{ #category : #'api - changes' }
ToAptitude >> addChange: aLookChange [
	changes add: aLookChange.
	widget ifNotNil: [ aLookChange upOn: self ]
]

{ #category : #'api - changes' }
ToAptitude >> addChangeAddChild: aCollection with: aBlock [
	self
		addChange:
			(ToLookAddChildChange new
				path: aCollection;
				value: aBlock;
				yourself)
]

{ #category : #'api - changes' }
ToAptitude >> addChangeAddChildAs: aCollection with: aBlock [
	self
		addChange:
			(ToLookAddChildAsChange new
				path: aCollection;
				value: aBlock;
				yourself)
]

{ #category : #'api - changes' }
ToAptitude >> addChangeAddChildFirst: aCollection with: aBlock [
	"Add the supplied change, which will add an element as the first child of the target element"
	self
		addChange:
			(ToLookAddChildFirstChange new
				path: aCollection;
				value: aBlock;
				yourself)
]

{ #category : #'api - changes' }
ToAptitude >> addChangeProperty2: aCollection with: aBlock [
	self
		addChange:
			(ToLookPropertyChange2 new
				path: aCollection;
				value: aBlock;
				yourself)
]

{ #category : #'api - changes' }
ToAptitude >> addChangeProperty: aCollection with: aBlock [
	self
		addChange:
			(ToLookPropertyChange new
				path: aCollection;
				value: aBlock;
				yourself)
]

{ #category : #'api - changes' }
ToAptitude >> addChangeProperty: aCollection withCopy: aBlock [
	self
		addChange:
			(ToLookPropertyCopyChange new
				path: aCollection;
				value: aBlock;
				yourself)
]

{ #category : #'api - composition' }
ToAptitude >> asLook [
	^ self
]

{ #category : #'api - changes' }
ToAptitude >> changes [
	^ changes
]

{ #category : #'event management' }
ToAptitude >> dispatchEvent: anEvent [

	super dispatchEvent: anEvent.
]

{ #category : #initialization }
ToAptitude >> initialize [
	super initialize.
	changes := ToLookChanges new
]

{ #category : #initialization }
ToAptitude >> initializeRequests [
	"Override me to implement requests to the view model to synchronise its properties"
]

{ #category : #accessing }
ToAptitude >> looks [
	^ self children
]

{ #category : #'api - hooks' }
ToAptitude >> onAttachedTo: anElement [
	"Is sent when I am added to an element (or to the other actor which is added to the element)"

	self
		assert: [ widget isNil ]
		description: [ 'Can not install the same look instance on multiple widgets' ].

	widget := anElement.
	
	self transferEventHandlersToWidget
]

{ #category : #'api - hooks' }
ToAptitude >> onInstalledIn: anElement [
	self withAllActorsBreadthFirstDo: [ :eachLook | eachLook onAttachedTo: anElement ].
	self withAllActorsBreadthFirstDo: [ :eachLook | eachLook changes upOn: eachLook ].
	self withAllActorsBreadthFirstDo: [ :eachLook | eachLook initializeRequests ]
]

{ #category : #'api - hooks' }
ToAptitude >> onUninstalledIn: anElement [
	super onUninstalledIn: anElement.

	self
		assert: [ self widget == anElement ]
		description: [ 'Can not uninstall from a different widget' ].

	self looks reversed do: [ :aLook | aLook onUninstalledIn: anElement ].

	changes downOn: self.
	widget := nil.
	
	self initializeListeners
]

{ #category : #'api - composition' }
ToAptitude >> remove: aBrLook [
	"Remove a given look if it exists"
	| aLookInstance |

	aLookInstance := aBrLook asLook.
	
	(actors includes: aLookInstance)
		ifFalse: [ ^ self ].
	
	actors := actors copyWithout: aLookInstance.
	aLookInstance widgetDo: [ :anElement | aLookInstance onUninstalledIn: anElement ]
]

{ #category : #accessing }
ToAptitude >> widgetContent [
	"Return widget's content container element"
	<return: #BlElement>

	self
		assert: [ widget isNotNil ]
		description: [ 'I must be attached to the widget first' ].

	"if widget does not have explicit #content container, we treat widget as a container itself"
	^ widget
		directChildNamed: #content
		ifFound: [ :anElement | anElement ]
		ifNone: [ widget ]
]

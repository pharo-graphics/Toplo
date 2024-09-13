Class {
	#name : #ToCheckableGroup,
	#superclass : #Object,
	#traits : 'TBlEventTarget',
	#classTraits : 'TBlEventTarget classTrait',
	#instVars : [
		'checkingStrategy',
		'eventDispatcher',
		'registeredCheckables'
	],
	#category : #'Toplo-Widget-Button-Checkable'
}

{ #category : #'checking / unchecking request' }
ToCheckableGroup >> allowChangeWith: aCheckValue forCheckable: target [

	^ (checkingStrategy
			 allowChangeWith: aCheckValue
			 in: self
			 forCheckable: target)
]

{ #category : #'checking / unchecking request' }
ToCheckableGroup >> checkableChangedEvent: aCheckedEvent [

	self notifyChanged

]

{ #category : #accessing }
ToCheckableGroup >> checkedList [

	^ registeredCheckables select: [ :b | b checked ]
]

{ #category : #accessing }
ToCheckableGroup >> checkingStrategy [

	^ checkingStrategy
]

{ #category : #accessing }
ToCheckableGroup >> checkingStrategy: aCheckableGroupCheckingStrategy [

	checkingStrategy := aCheckableGroupCheckingStrategy
]

{ #category : #initialization }
ToCheckableGroup >> defaultCheckStrategy [

	^ ToCheckableGroupStrictStrategy new
]

{ #category : #'event management accessing' }
ToCheckableGroup >> eventDispatcher [
	"Return an object responsible for event dispatching"
	<return: #BlDirectEventDispatcher>

	^ eventDispatcher
]

{ #category : #testing }
ToCheckableGroup >> hasNoneStrategy [

	^ checkingStrategy isNoneStrategy 
]

{ #category : #initialization }
ToCheckableGroup >> initialize [ 

	super initialize.
	eventDispatcher := BlDirectEventDispatcher on: self.
	checkingStrategy := self defaultCheckStrategy.
	registeredCheckables := ToObservableCollection new.
	registeredCheckables addEventHandler: (ToCheckableGroupCollectionEventHandler new checkableGroup: self; yourself).

	self notifyChanged
]

{ #category : #'checking protocol' }
ToCheckableGroup >> notifyChanged [

	self dispatchEvent: (ToCheckableGroupChangedEvent new
			 checkedList: self checkedList;
			 uncheckedList: self uncheckedList;
			 yourself)
]

{ #category : #'registering / unregistering' }
ToCheckableGroup >> register: aCheckable [

	registeredCheckables add: aCheckable
]

{ #category : #'registering / unregistering' }
ToCheckableGroup >> registerAll: aCollection [

	registeredCheckables addAll: aCollection
]

{ #category : #accessing }
ToCheckableGroup >> registeredCheckables [

	^ registeredCheckables
]

{ #category : #'checking / unchecking request' }
ToCheckableGroup >> uncheckAll [

	self checkedList do: [ :b | b checkableData privateChecked: false ]
]

{ #category : #'checking / unchecking request' }
ToCheckableGroup >> uncheckAllExcept: aButton [

	(self registeredCheckables select: [ :b |
		 b ~= aButton and: [ b checked ] ]) do: [ :b |
		b checkableData privateChecked: false ]
]

{ #category : #accessing }
ToCheckableGroup >> uncheckedList [

	^ registeredCheckables reject: [ :b | b checked ]
]

{ #category : #'registering / unregistering' }
ToCheckableGroup >> unregister: aCheckable [

	registeredCheckables remove: aCheckable
]

{ #category : #'registering / unregistering' }
ToCheckableGroup >> unregisterAll [

	registeredCheckables removeAll
]

{ #category : #'checking protocol' }
ToCheckableGroup >> withStrictCheckingStrategy [

	self checkingStrategy: ToCheckableGroupStrictStrategy new
]

{ #category : #'checking protocol' }
ToCheckableGroup >> withWeakCheckingStrategy [

	self checkingStrategy: ToCheckableGroupWeakStrategy new
]

{ #category : #'checking protocol' }
ToCheckableGroup >> withoutCheckingStrategy [

	self checkingStrategy: ToCheckableGroupNoneStrategy new
]

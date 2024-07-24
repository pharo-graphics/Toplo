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

{ #category : #'registering / unregistering' }
ToCheckableGroup >> add: aCheckable [
	self
		deprecated: 'send #register: instead'
		transformWith:
		'`@receiver add: `@arg' -> '`@receiver register: `@arg'.

	self register: aCheckable
]

{ #category : #'registering / unregistering' }
ToCheckableGroup >> addAll: aCollection [

	self
		deprecated: 'send #registerAll: instead'
		transformWith:
		'`@receiver addAll: `@arg' -> '`@receiver registerAll: `@arg'.

	self registerAll: aCollection
]

{ #category : #'checking / unchecking request' }
ToCheckableGroup >> allowChangeWith: aCheckValue forCheckable: target [

	^ (checkingStrategy
			 allowChangeWith: aCheckValue
			 in: self
			 forCheckable: target)
]

{ #category : #testing }
ToCheckableGroup >> allowUnchecking [

	^ checkingStrategy allowUnchecking
]

{ #category : #accessing }
ToCheckableGroup >> buttons [
	
	self deprecated: 'send #registeredCheckables instead'
		transformWith: '`@receiver buttons'
						-> '`@receiver registeredCheckables'.

	^ self registeredCheckables
]

{ #category : #'checking / unchecking request' }
ToCheckableGroup >> checkableChangedEvent: aCheckedEvent [

	self notifyChanged

]

{ #category : #accessing }
ToCheckableGroup >> checkedButtons [

	self
		deprecated: 'send #checkedList instead'
		transformWith:
		'`@receiver checkedButtons' -> '`@receiver checkedList'.

	^ self checkedList 
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

{ #category : #'registering / unregistering' }
ToCheckableGroup >> remove: aCheckable [

	self
		deprecated: 'send #unregister: instead'
		transformWith:
		'`@receiver remove: `@arg' -> '`@receiver unregister: `@arg'.
	self unregister: aCheckable 
]

{ #category : #'registering / unregistering' }
ToCheckableGroup >> removeAll [

	self
		deprecated: 'send #unregisterAll instead'
		transformWith: '`@receiver removeAll' -> '`@receiver unregisterAll'.


	self unregisterAll
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
ToCheckableGroup >> uncheckedButtons [

	self
		deprecated: 'send #uncheckedList instead'
		transformWith:
		'`@receiver uncheckedButtons' -> '`@receiver uncheckedList'.
	^ self uncheckedList
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

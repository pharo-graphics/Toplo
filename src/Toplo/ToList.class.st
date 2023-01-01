Class {
	#name : #ToList,
	#superclass : #OBlInfiniteElement,
	#traits : 'TOBlLayoutResizable + TToDressable',
	#classTraits : 'TOBlLayoutResizable classTrait + TToDressable classTrait',
	#instVars : [
		'nodeFactory',
		'selectionModel'
	],
	#category : #'Toplo-Widget-List'
}

{ #category : #initialization }
ToList >> defaultDataSource [

	^ ToListDataSource new
]

{ #category : #'t - initialization dresser' }
ToList >> defaultDresser [ 

	^ ToListDresser new
]

{ #category : #initialization }
ToList >> defaultLayout [

	^ OBlInfiniteLinearLayout new
]

{ #category : #initialization }
ToList >> holderClass [

	^ ToListNodeHolder 
]

{ #category : #initialization }
ToList >> initialize [ 

	super initialize.
	nodeFactory := [ :d | ToLabeledNode new labelText: d ].
	selectionModel := ToSelectionModel new.
	self list: ToObservableCollection new.	
	self constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical matchParent ].
	self initializeDresser 
]

{ #category : #accessing }
ToList >> list [

	^ dataSource list
]

{ #category : #accessing }
ToList >> list: aList [

	dataSource list: aList
]

{ #category : #accessing }
ToList >> nodeFactory [

	^ nodeFactory 
]

{ #category : #accessing }
ToList >> nodeFactory: aValuable [

	nodeFactory := aValuable
]

{ #category : #accessing }
ToList >> selectionModel [

	^ selectionModel 
]

{ #category : #'selection events' }
ToList >> whenClickOnNodeAnnouncement: anAnnouncement [

	self selectionModel selectOne: anAnnouncement holder layoutPosition dueTo: anAnnouncement event
]

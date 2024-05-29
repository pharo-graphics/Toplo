Class {
	#name : #ToCompositeSelecter,
	#superclass : #ToListElementSelecter,
	#category : #'Toplo-Widget-List-Selection-Selecter'
}

{ #category : #'instance creation' }
ToCompositeSelecter class >> selectionModel: aSelectionModel operator: anOperator [

	^ self new
		  selectionModel: aSelectionModel;
		  operator: anOperator;
		  yourself
]

{ #category : #'instance creation' }
ToCompositeSelecter >> newOperator [ 

	^ self subclassResponsibility 
]

{ #category : #'api - hooks' }
ToCompositeSelecter >> onInstalledIn: anEventTarget [

	super onInstalledIn: anEventTarget.
	operator := self newOperator.
	operator onInstalledIn: anEventTarget.
	selectionModel := self selectionModelInEventTarget: anEventTarget.
	selectionModel onInstalledIn: anEventTarget
]

{ #category : #'api - hooks' }
ToCompositeSelecter >> onUninstalledIn: anEventTarget [

	operator onUninstalledIn: anEventTarget.
	operator := nil.
	selectionModel onUninstalledIn: anEventTarget.
	selectionModel := nil.
	super onUninstalledIn: anEventTarget
]

{ #category : #accessing }
ToCompositeSelecter >> selectionModelInEventTarget: anEventTarget [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToCompositeSelecter >> subSelecterIndex [

	^ self subclassResponsibility 
]

{ #category : #accessing }
ToCompositeSelecter >> subSelecterWithId: anUniqueId [

	^ self subSelecterIndex  at: anUniqueId ifAbsent: [  ]
]

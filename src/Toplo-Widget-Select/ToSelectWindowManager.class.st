Class {
	#name : 'ToSelectWindowManager',
	#superclass : 'ToPopupWindowManager',
	#instVars : [
		'listElement'
	],
	#category : 'Toplo-Widget-Select',
	#package : 'Toplo-Widget-Select'
}

{ #category : 'accessing' }
ToSelectWindowManager >> data [

	^ self listElement data
]

{ #category : 'initialization' }
ToSelectWindowManager >> defaultWidthtHook [

	^ [ :event :theElement | theElement measuredWidth ]
]

{ #category : 'accessing' }
ToSelectWindowManager >> elementEventHandlerClass [ 

	^ ToSelectEventHandler
]

{ #category : 'initialization' }
ToSelectWindowManager >> initialize [ 

	super initialize.
	listElement := ToListElement new matchParent.
	listElement addEventHandler: (BlEventHandler
			 on: ToListElementSelectionChangedEvent
			 do: [ :evt | evt sendTo: self  ]).
	self builder: [ :selectWin :request | 
		selectWin root matchParent.
		selectWin root addChild: self listElement ].
]

{ #category : 'accessing' }
ToSelectWindowManager >> listElement [

	^ listElement 
]

{ #category : 'element handlers' }
ToSelectWindowManager >> listElementSelectionChangedEvent: anEvent [

	self element selectIndexes: anEvent newSelectedIndexes
]

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
	self builder: [ :selectWin :request | 
		selectWin root matchParent.
		selectWin root addChild: self listElement ].
]

{ #category : 'accessing' }
ToSelectWindowManager >> listElement [

	^ listElement 
]

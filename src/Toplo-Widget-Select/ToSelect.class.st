Class {
	#name : 'ToSelect',
	#superclass : 'ToPane',
	#instVars : [
		'windowManager'
	],
	#category : 'Toplo-Widget-Select',
	#package : 'Toplo-Widget-Select'
}

{ #category : 'accessing' }
ToSelect >> data [

	^ self listElement data
]

{ #category : 'initialization' }
ToSelect >> initialize [ 

	super initialize.
	windowManager := ToSelectWindowManager new element: self.
	windowManager widthHook: [ :theWindow :theElement | theElement measuredWidth ].	
	windowManager heightHook: [ :theWindow :theElement | 400 ].
]

{ #category : 'accessing' }
ToSelect >> listElement [

	^ self windowManager listElement
]

{ #category : 't - infinite accessing' }
ToSelect >> nodeBuilder: aNodeFactory [

	self listElement nodeBuilder: aNodeFactory
]

{ #category : 'accessing' }
ToSelect >> windowManager [

	^ windowManager 
]

Class {
	#name : #ToCircularMenu,
	#superclass : #ToMenu,
	#traits : 'TToCircularMenuListUser',
	#classTraits : 'TToCircularMenuListUser classTrait',
	#category : #'Toplo-Widget-Menu-Items'
}

{ #category : #accessing }
ToCircularMenu >> defaultWindowMeasurement [

	^ ToCircularMenuWindowMeasurement new
]

{ #category : #accessing }
ToCircularMenu >> defaultWindowPlacement [

	^ ToCircularMenuWindowPlacement new
]

{ #category : #accessing }
ToCircularMenu >> innerRadius: aFloat [ 

	self itemList innerRadius: aFloat 
]

{ #category : #'t - item list owner - initializing' }
ToCircularMenu >> newItemList [ 

	^ ToCircularMenuList new
]

{ #category : #accessing }
ToCircularMenu >> windowClass [ 

	^ ToCircularMenuWindow
]

{ #category : #accessing }
ToCircularMenu >> windowStarter [

	^ ToCircularMenuWindowStarter new
]

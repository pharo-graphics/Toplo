Class {
	#name : #ToCircularMenu,
	#superclass : #ToMenu,
	#traits : 'TToCircularMenuListUser',
	#classTraits : 'TToCircularMenuListUser classTrait',
	#instVars : [
		'encompassing'
	],
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
ToCircularMenu >> encompassing [

	^ encompassing ifNil: [ encompassing := true ]
]

{ #category : #accessing }
ToCircularMenu >> encompassing: aBoolean [

	encompassing := aBoolean
]

{ #category : #accessing }
ToCircularMenu >> innerRadius [

	^ self itemList innerRadius
]

{ #category : #accessing }
ToCircularMenu >> innerRadius: aFloat [

	(self innerRadius closeTo: aFloat) ifTrue: [ ^ self ].
	self itemList innerRadius: aFloat
]

{ #category : #'t - item list owner - initializing' }
ToCircularMenu >> newItemList [ 

	^ ToCircularMenuList new
]

{ #category : #accessing }
ToCircularMenu >> uniformSectors: aBoolean [

	self itemList uniformSectors: aBoolean
]

{ #category : #accessing }
ToCircularMenu >> windowClass [ 

	^ ToCircularMenuWindow
]

{ #category : #accessing }
ToCircularMenu >> windowStarter [

	^ ToCircularMenuWindowStarter new
]

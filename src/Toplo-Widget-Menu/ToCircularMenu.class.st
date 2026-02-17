Class {
	#name : #ToCircularMenu,
	#superclass : #ToMenu,
	#traits : 'TToAnnulusSectorLayoutUser + TToAnnulusCircularLayoutUser',
	#classTraits : 'TToAnnulusSectorLayoutUser classTrait + TToAnnulusCircularLayoutUser classTrait',
	#instVars : [
		'encompassing'
	],
	#category : #'Toplo-Widget-Menu-Circular'
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

{ #category : #'t - item list owner - initializing' }
ToCircularMenu >> newItemList [ 

	^ ToCircularMenuList new
]

{ #category : #'t - annulus sector layout user' }
ToCircularMenu >> stateHolder [

	^ self itemList
]

{ #category : #accessing }
ToCircularMenu >> windowClass [ 

	^ ToCircularMenuWindow
]

{ #category : #accessing }
ToCircularMenu >> windowStarter [

	^ ToCircularMenuWindowStarter new
]

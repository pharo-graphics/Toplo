Class {
	#name : #ToCircularMenuList,
	#superclass : #ToMenuItemListElement,
	#category : #'Toplo-Widget-Menu-Circular'
}

{ #category : #initialization }
ToCircularMenuList >> defaultInnerElementClass [ 

	^ ToCircularMenuInnerElement 
]

{ #category : #initialization }
ToCircularMenuList >> defaultNodeManager [

	^ super defaultNodeManager
		  nodeContainerFactory: [ ToCircularMenuNodeContainer new ];
		  nodeFactory: [ :holder | ToCircularMenuNode new ];
		  yourself
]

{ #category : #initialization }
ToCircularMenuList >> initialize [

	super initialize.
	self geometry: BlCircleGeometry new.
	self secondarySelectionOption elementFactory: [
		ToCircularMenuListSecondarySelectionElement new ].
	self matchParent.
	self preventMouseEvents 
]

{ #category : #accessing }
ToCircularMenuList >> innerRadius: aFloat [

	self innerElement innerRadius: aFloat
]

{ #category : #accessing }
ToCircularMenuList >> outerRadius: aFloat [

	self innerElement outerRadius: aFloat
]

{ #category : #accessing }
ToCircularMenuList >> uniformSectors: aBoolean [

	self innerElement uniformSectors: aBoolean
]

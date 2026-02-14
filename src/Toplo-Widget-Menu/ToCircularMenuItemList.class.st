Class {
	#name : #ToCircularMenuItemList,
	#superclass : #ToMenuItemListElement,
	#category : #'Toplo-Widget-Menu-Circular'
}

{ #category : #initialization }
ToCircularMenuItemList >> defaultInnerElementClass [ 

	^ ToCircularMenuInnerElement 
]

{ #category : #initialization }
ToCircularMenuItemList >> defaultNodeManager [

	^ super defaultNodeManager
		  nodeContainerFactory: [ ToCircularMenuNodeContainer new ];
		  nodeFactory: [ :holder | ToCircularMenuNode new ];
		  yourself
]

{ #category : #initialization }
ToCircularMenuItemList >> initialize [

	super initialize.
	self geometry: BlCircleGeometry new.
	self secondarySelectionOption elementFactory: [
		ToCircularMenuItemListSecondarySelectionElement new ].
	self matchParent.
	self preventMouseEvents 
]

{ #category : #accessing }
ToCircularMenuItemList >> innerRadius: aFloat [

	self innerElement innerRadius: aFloat
]

{ #category : #accessing }
ToCircularMenuItemList >> outerRadius: aFloat [

	self innerElement outerRadius: aFloat
]

{ #category : #accessing }
ToCircularMenuItemList >> uniformSectors: aBoolean [

	self innerElement uniformSectors: aBoolean
]

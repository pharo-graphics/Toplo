Class {
	#name : #ToCircularMenuList,
	#superclass : #ToMenuItemListElement,
	#traits : 'TToAnnulusSectorLayoutUser + TToAnnulusCircularLayoutUser',
	#classTraits : 'TToAnnulusSectorLayoutUser classTrait + TToAnnulusCircularLayoutUser classTrait',
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

{ #category : #'t - annulus sector layout user' }
ToCircularMenuList >> stateHolder [

	^ self innerElement 
]

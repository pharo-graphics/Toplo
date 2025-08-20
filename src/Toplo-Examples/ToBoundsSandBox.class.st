Class {
	#name : #ToBoundsSandBox,
	#superclass : #Object,
	#category : #'Toplo-Examples-Experiments'
}

{ #category : #accessing }
ToBoundsSandBox class >> exampleWithSandBox [

	| main child1 child2 childchild11 childchild12 childchild21 childchild22 |
	main := self sandBox.
	child1 := main childWithId: #child1.
	child2 := main childWithId: #child2.
	childchild11 := main childWithId: #childchild11.
	childchild12 := main childWithId: #childchild12.
	childchild21 := main childWithId: #childchild21.
	childchild22 := main childWithId: #childchild22.

	main whenLayoutedDoOnce: [
			childchild22 bounds traceCr.
			childchild22 bounds traceCr.
			(childchild22 bounds inSpace inChild: child2) traceCr ].

	main openInSpace
]

{ #category : #accessing }
ToBoundsSandBox class >> sandBox [

	| main child1 child2 childchild11 childchild12 childchild21 childchild22 |
	main := ToElement new
		        extent: 500 asPoint;
		        id: #main;
		        yourself.
	main layout: BlLinearLayout horizontal.
	child1 := ToElement new
		          extent: 200 asPoint;
		          id: #child1;
		          yourself.
	child1 padding: (BlInsets all: 10).
	child1 layout: BlLinearLayout horizontal.
	child2 := ToElement new
		          extent: 200 asPoint;
		          id: #child2;
		          yourself.
	child2 padding: (BlInsets all: 20).
	child2 layout: BlLinearLayout horizontal.
	childchild11 := ToElement new
		                size: 50 asPoint;
		                id: #childchild11;
		                yourself.
	childchild11 layout: BlLinearLayout horizontal.
	childchild12 := ToElement new
		                size: 50 asPoint;
		                id: #childchild12;
		                yourself.
	childchild12 layout: BlLinearLayout horizontal.
	childchild21 := ToElement new
		                size: 50 asPoint;
		                id: #childchild21;
		                yourself.
	childchild21 layout: BlLinearLayout horizontal.
	childchild22 := ToElement new
		                size: 50 asPoint;
		                id: #childchild22;
		                yourself.
	childchild22 layout: BlLinearLayout horizontal.

	{
		child1.
		child2.
		childchild11.
		childchild12.
		childchild21.
		childchild22 } do: [ :c | c background: Color random ].


	main addChildren: {
			child1.
			child2 }.
	child1 addChildren: {
			childchild11.
			childchild12 }.
	child2 addChildren: {
			childchild21.
			childchild22 }.

	main position: 100 asPoint.
	^ main
]
